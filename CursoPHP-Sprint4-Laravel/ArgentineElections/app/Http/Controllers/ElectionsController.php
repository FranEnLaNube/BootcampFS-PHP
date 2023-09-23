<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Election;
use Illuminate\Http\Request;


class ElectionsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $elections = Election::all();
        $years = [];

        foreach ($elections as $election) {
            $year = strtotime($election->date);
            $years[] = date("Y", $year);
        }

        return view('entities.elections.index')->with([
            'elections' => $elections,
            'years' => $years,
        ]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('entities.elections.create');
    }
    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $election = new Election();
        $election->date = $request->get('date');

        $election->save();

        return redirect('/elections');
    }
    /**
     * Display the specified resource.
     */
    public function show(string $year)
    {
        $election = Election::whereYear('date', $year)->first();
        return view('entities.elections.show')->with(['election' => $election, 'year' => $year]);
    }
    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $year)
    {
        $election = Election::whereYear('date', $year)->first();
        return view('entities.elections.edit')->with(['election' => $election, 'year' => $year]);
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $year)
    {
        $election = Election::whereYear('date', $year)->first();
        $election->date = $request->get('date');
        $election->save();
        return redirect('/elections');
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $year)
    {
        $election = Election::whereYear('date', $year)->first();
        $election->delete();
        return redirect('/elections');
    }
}