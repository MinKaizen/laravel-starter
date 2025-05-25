<?php

declare(strict_types=1);

// (no need for namespace here)

if (! function_exists('remove_accents')) {
    function remove_accents(string $original): string
    {
        if (extension_loaded('intl') && function_exists('transliterator_transliterate')) {
            $new = transliterator_transliterate('Any-Latin; Latin-ASCII', $original);

            return is_string($new) ? $new : $original;
        }

        if (function_exists('iconv')) {
            $new = iconv('UTF-8', 'ASCII//TRANSLIT', $original);

            return is_string($new) ? $new : $original;
        }

        return $original;
    }
}
