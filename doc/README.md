# siloutil::plain
This class implements and supplements function from <nobr>src/hooks/plain</nobr> 

Found in file: <nobr>siloutil/python_package/siloutil/__init__.py</nobr>

---
## Public Members

Member | Type | Description
-------|------|------------
[`version`](#classsiloutil_1_1plain_1a22961651ba4cf16cb567de62fa45a7a1)|list|Versionnumber. 
[`__init__`](#classsiloutil_1_1plain_1a48f56910eb6ca2849446a22503e98b7b)| function |Constructor, sets locale. 

<div style="text-align: right"><a href="#top">Back to top</a></div>

---
### `version` {#classsiloutil_1_1plain_1a22961651ba4cf16cb567de62fa45a7a1}
Version number of the hook, adheres to semantic versioning 
<dl>
	<dt>Type</dt><dd>list</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>yes</dd>
</dl>

```python
	version = [1, 0, 0]
```
<p/><div style="text-align: right"><a href="#top">Back to top</a></div>

---
### `__init__` {#classsiloutil_1_1plain_1a48f56910eb6ca2849446a22503e98b7b}
Here we invoke the construtor of the C++ class and use the exported setLocale() function to set language files' path and current locale 
<dl>
	<dt>Attributes</dt>
	<dd>self: the self object </dd>
	<dt>Returns</dt><dd>None</dd>
	<dt>Protection</dt><dd>public</dd>
	<dt>Static</dt><dd>no</dd>
	<dt>Const</dt><dd>no</dd>
</dl>

```python
	def __init__(self):
		plain_hook.siloutil.__init__(self)
		self.setLocale("", _os.path.dirname(plain_hook.__file__))
```
<p/><div style="text-align: right"><a href="#top">Back to top</a></div>

---
## Private Members
None

<div style="text-align: right"><a href="#top">Back to top</a></div>

---
## Full Code
```python
class plain(plain_hook.siloutil):
	## Versionnumber
	#
	# Version number of the hook, adheres to semantic versioning
	version = [1, 0, 0]
	## Constructor, sets locale
	#
	# Here we invoke the construtor of the C++ class and use the exported
	# setLocale() function to set language files' path and current locale
	# @param self the self object
	def __init__(self):
		plain_hook.siloutil.__init__(self)
		self.setLocale("", _os.path.dirname(plain_hook.__file__))
```
<p/><div style="text-align: right"><a href="#top">Back to top</a></div>

---
