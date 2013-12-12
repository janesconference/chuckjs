# ChuckJS

JavaScript ([CoffeeScript](http://coffeescript.org/)) parser for the [ChucK](http://chuck.cs.princeton.edu/) music programming language.

This project is just in its infancy at this stage, so do not expect working code yet. I've just implemented parsing of
a small part of the grammar, and am about to start working on the VM.

## Build

In order to build ChuckJS, you'll need an installation of [Node](http://nodejs.org/) along with
[NPM](https://npmjs.org/). If you haven't already installed [Grunt](http://gruntjs.com), install it system-wide:

    npm install -g grunt-cli

Then, within the ChuckJS project root, install its dependencies (beneath the project root) via NPM:

    npm install

After doing this, you should be able to build ChuckJS, by running grunt:

    grunt

At this point, the parser has been built as lib/parser.js. CoffeeScript source files (in src/) are also compiled to
JavaScript beneath lib/.

## Test

There is currently a single, simple test for ChuckJS, testparse.js. Run it as follows (after building with grunt):

    node testparse.js

