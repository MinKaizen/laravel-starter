<?php

namespace App\Livewire;

use Livewire\Component;

final class Counter extends Component
{
    public int $count = 0;

    public function increment(): void
    {
        $this->count++;
    }

    public function decrement(): void
    {
        $this->count--;
    }

    public function render(): \Illuminate\Contracts\View\View
    {
        return view('livewire.counter');
    }
}
