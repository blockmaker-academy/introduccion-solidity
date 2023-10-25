// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnicodeExamples {
    string public unicodeString1;
    string public unicodeString2;

    constructor() {
        // Example 1: Using the word "unicode" with a smiley face 😃
        unicodeString1 = unicode"fun 😃";

        // Example 3: Using the word "unicode" with a thumbs up 👍
        unicodeString2 = unicode"Thumbs up 👍";
    }
}

