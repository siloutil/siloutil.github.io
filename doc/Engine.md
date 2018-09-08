# `Engine`
This class wraps around the bare silo API functions 

Found in file: <nobr>/home/niklas/siloutil/siloutil/src/base-engine/Engine.hpp</nobr>

---
## Public Members

Member | Type | Description
-------|------|------------
[`Engine`](#class_engine_1a8c98683b0a3aa28d8ab72a8bcd0d52f2)| function |Constructor. 
[`~Engine`](#class_engine_1a8ef7030a089ecb30bbfcb9e43094717a)| function |Trivial destructor. 
[`getSiloVersionStr`](#class_engine_1a2c65522239ee0eb869925f9b526ba166)| function |Silo version. 
[`getSiloVersionInt`](#class_engine_1ac532ba729c7307c00eb05d3896076e7c)| function |Silo version. 

<div style="text-align: right"><a href="#top">Back to top</a></div>

---
### `Engine` {#class_engine_1a8c98683b0a3aa28d8ab72a8bcd0d52f2}
Gets info about linked silo library 
<dl>
	<dt>Attributes</dt>
	<dd></dd>
	<dt>Returns</dt><dd>None</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>no</dd>
	<dt>Const</dt><dd>no</dd>
</dl>

```cpp
Engine::Engine() {
    int Maj, Min, Pat, Pre;
    DBVersionDigits(&Maj, &Min, &Pat, &Pre);
    siloVersion = {Maj, Min, Pat, Pre};
}
```
### `~Engine` {#class_engine_1a8ef7030a089ecb30bbfcb9e43094717a}
Does nothing 
<dl>
	<dt>Attributes</dt>
	<dd></dd>
	<dt>Returns</dt><dd>None</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>no</dd>
	<dt>Const</dt><dd>no</dd>
</dl>

```cpp
Engine::~Engine() {
    ;
}
```
### `getSiloVersionStr` {#class_engine_1a2c65522239ee0eb869925f9b526ba166}
Outputs a string of the silo version, spearated by dots 
<dl>
	<dt>Attributes</dt>
	<dd></dd>
	<dt>Returns</dt><dd>None</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>no</dd>
	<dt>Const</dt><dd>no</dd>
</dl>

```cpp
std::string Engine::getSiloVersionStr() {
    std::string strVersion =       std::to_string( siloVersion.at(0) );
    strVersion            += "." + std::to_string( siloVersion.at(1) );
    strVersion            += "." + std::to_string( siloVersion.at(2) );
    return strVersion;
}
```
### `getSiloVersionInt` {#class_engine_1ac532ba729c7307c00eb05d3896076e7c}
Outputs a string of the silo version, spearated by dots 
<dl>
	<dt>Attributes</dt>
	<dd></dd>
	<dt>Returns</dt><dd>None</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>no</dd>
	<dt>Const</dt><dd>no</dd>
</dl>

```cpp
std::vector<int> Engine::getSiloVersionInt() {
    return siloVersion;
}
```
<p/><div style="text-align: right"><a href="#top">Back to top</a></div>

---
## Private Members
None

<div style="text-align: right"><a href="#top">Back to top</a></div>

---
## Full Code
```cpp
class Engine {
  private:
    //! Silo version
    /*! Vector of major/minor/sub version numbers in that order. */
    std::vector<int> siloVersion;

  public:
    //! Constructor
    /*!
       Gets info about linked silo library
    */
    Engine();

    //! Trivial destructor
    /*!
       Does nothing
    */
   ~Engine();

    //! Silo version
    /*!
      Outputs a string of the silo version, spearated by dots
    */
    std::string getSiloVersionStr();

    //! Silo version
    /*!
      Outputs a string of the silo version, spearated by dots
    */
    std::vector<int> getSiloVersionInt();
};
```
<p/><div style="text-align: right"><a href="#top">Back to top</a></div>

---
