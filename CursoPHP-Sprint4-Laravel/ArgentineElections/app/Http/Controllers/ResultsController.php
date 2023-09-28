<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Alternative;
use App\Models\Election;
use App\Models\Province;
use App\Models\Vote;
use Illuminate\Validation\Rules\Exists;

class ResultsController extends Controller
{

    /**
     * Display available elections from database.
     */
    public function showElections()
    {
        // Find elections with associated votes
        $electionsWithVotes = Election::has('elections_votes_alternatives')->get();
        //$election = Election::whereYear('date', $year)->first();

        $blankSpoiled = 2;
        foreach ($electionsWithVotes as $electionWithVotes) {
            $altQuantity = ($electionWithVotes->elections_votes_alternatives->first()->count() - $blankSpoiled);
            if (date('Y', strtotime($electionWithVotes->date))) {
                $year = date('Y', strtotime($electionWithVotes->date));
                $message = "In this election have participated " . $altQuantity . " parties";
            } else {
                $year = "There are no elections yet.";
                $votesLink = "{{<a href='/votes/create'>votes</a>}}";
                $message = "Please add one in " . $votesLink . " section.";
            }
            $electionData[$year] = $altQuantity;
        }
        $totalElections = count($electionData);
        $columns = 3; // Default columns number
        if ($totalElections === 0) {
            $columns = 1;
        } elseif ($totalElections === 1) {
        } elseif ($totalElections === 2) {
            $columns = 2;
        }
        return view('entities.results.index', compact(['electionData', 'columns', 'message']));

    }
    /**
     * Display votes from a particular election.
     */
    public function showByYear(string $year)
    {
        // Find the election based on the provided year
        $election = Election::whereYear('date', $year)->first();
        if (!$election) {
            return abort(404); // TODO: Handle the case where the election is not found
        }

        $provinces = Province::all();
        //Old logic. Provinces are always the same, we don't need to find the relation with votes

        /* foreach ($provinces as $province) {
            $vote = Vote::where('election_id', $election->id)->first();
            $alternatives[] = Alternative::where('id', $vote->election->id)->first();
        } */
        // Or $provinces = $election->elections_votes_provinces;
        // Or $provinces = Province::all();

        // Get all alternatives and provinces related with the election
        $alternatives = $election->elections_votes_alternatives;

        // Get amount of votes for each province and each alternative
        $results = [];
        foreach ($provinces as $province) {
            $provinceName = $province->name;
            $provinceResults = [];
            foreach ($alternatives as $alternative) {
                $vote = Vote::where([
                    'election_id' => $election->id,
                    'province_id' => $province->id,
                    'alternative_id' => $alternative->id,
                ])->first();
                $provinceResults[$alternative->name] = $vote ? $vote->quantity : 0; // if the alternativa doesn't have, set 0
            }
            $results[$provinceName] = $provinceResults;
            $provincesId[$provinceName] = $province->id;
        }
        // TODO put results in a new folder entities/results
        return view('entities.results.show-election', compact('alternatives', 'provinces', 'year', 'results', 'provincesId'));
    }
    /**
     * Display votes from a particular province in one election.
     */
    public function showByProvince($year, $province_id)
    {
        // Find the election based on the provided year
        $election = Election::whereYear('date', $year)->first();
        if (!$election) {
            return abort(404); // TODO: Handle the case where the election is not found
        }
        // Get all alternatives related with the election
        $province = province::where('id', $province_id)->first();
        if (!$province) {
            return abort(404); // TODO: Handle the case where the election is not found
        }
        $alternatives = Vote::where([
            'election_id' => $election->id,
            'province_id' => $province_id
        ])->get();
        if (!$alternatives) {
            return abort(404); // TODO: Handle the case where the election is not found
        }
        // Get the total votes in this province
        $totalVotes = $alternatives->sum->quantity;
        foreach ($alternatives as $alternative) {
            $altName = $alternative->alternative->name;
            $altVotes = $alternative ? $alternative->quantity : 0; // Votes quantity or 0 if vote not exists
            //Save votes per each alternative
            $votes[$altName] = $altVotes;
            $percents[$altName] = number_format(($altVotes / $totalVotes) * 100, 2);
            $altIds[$altName] = $alternative->alternative->id;
        }
        arsort($votes);
        return view('entities.results.show-by-province', compact('year', 'province', 'votes', 'totalVotes', 'percents', 'altIds'));
    }
}