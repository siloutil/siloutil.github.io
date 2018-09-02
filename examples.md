# Let's see how this works
# class `Engine` {#class_engine}


Our main class.

This class wraps around the bare silo API functions

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public  Engine()` | Constructor.
`public  ~Engine()` | Trivial destructor.
`public std::string getSiloVersionStr()` | Silo version.
`public std::vector< int > getSiloVersionInt()` | Silo version.

## Members

### `public  Engine()` {#class_engine_1a8c98683b0a3aa28d8ab72a8bcd0d52f2}

Constructor.

Gets info about linked silo library

### `public  ~Engine()` {#class_engine_1a8ef7030a089ecb30bbfcb9e43094717a}

Trivial destructor.

Does nothing

### `public std::string getSiloVersionStr()` {#class_engine_1a2c65522239ee0eb869925f9b526ba166}

Silo version.

Outputs a string of the silo version, spearated by dots

### `public std::vector< int > getSiloVersionInt()` {#class_engine_1ac532ba729c7307c00eb05d3896076e7c}

Silo version.

Outputs a string of the silo version, spearated by dots

# class `Plain_Hook` {#class_plain___hook}


Our main class.

This class wraps around the bare silo API functions

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public  Plain_Hook()` | Constructor.
`public  ~Plain_Hook()` | Destructor.
`public int setLocale(std::string locale,std::string localePath)` | Sets global info.
`public std::string reportStart()` | Reports version and general info.

## Members

### `public  Plain_Hook()` {#class_plain___hook_1abc73049fe67e4b7b095e638402592832}

Constructor.

Initializes [Engine](#class_engine) object

### `public  ~Plain_Hook()` {#class_plain___hook_1a9eb6d939a19b9c066b98c8c07982c9e9}

Destructor.

Releases [Engine](#class_engine) object

### `public int setLocale(std::string locale,std::string localePath)` {#class_plain___hook_1a6e5ec7afcf922af564ce85cc01c2b99b}

Sets global info.

Sets info: locale, locale-path

### `public std::string reportStart()` {#class_plain___hook_1a9e5f9419b65853bbb400d25af11b4787}

Reports version and general info.

Prints info: version
