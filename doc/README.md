# `siloutil::plain`
## Info
This class implements and supplements function from src/hooks/plain. 

Found in file: siloutil/python\_package/siloutil/\_\_init\_\_.py

## Public Members

Member | Type | Description
-------|------|------------
[`version`](#classsiloutil_1_1plain_1a22961651ba4cf16cb567de62fa45a7a1)|list|Versionnumber. 
[`__init__`](#classsiloutil_1_1plain_1a48f56910eb6ca2849446a22503e98b7b)| function |Constructor, sets locale. 

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

## Private Memers
None

## Full Code
