<div class="flex flex-col items-center gap-3">
    <div class="grid border-gray-800 px-6 py-4 rounded-lg bg-gray-900 shadow-lg">
        Count: {{$count}}
    </div>
    <div class="grid gap-2 text-xl grid-cols-2 h-max w-max">
        <button wire:click="increment" class="text-xl font-bold grid aspect-square rounded bg-gray-800 hover:bg-gray-700">+</button>
        <button wire:click="decrement" class="text-xl font-bold grid aspect-square rounded bg-gray-800 hover:bg-gray-700">-</button>
    </div>
</div>
