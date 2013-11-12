# NSFastEnumeration or Consequences

- what & why it is
- how (and when) to call it
- how (and when) to implement it
- its limitations, and to do about them

## What it is (10min)

- this is how `for(id a in A)` is implemented

- protocol for enumerating 0 or more objects sequentially

- *fast*

- has a single method, `-countByEnumeratingWithState:objects:count:`

- three parameters:
	- pointer to an `NSFastEnumerationState` struct
		- `state` for arbitrary data
		- `itemsPtr` is a pointer to 0 or more objects; must be valid to dereference if the returned count > 0
		- `mutationsPtr` is a pointer to an unsigned long value that must not change during enumeration (which lets callers error-check); this must be valid to dereference
		- array of five `unsigned long`s for arbitrary data
	- buffer of objects that the receiver can write references into
	- length of that buffer

- (potentially) gets called multiple times

## Calling it (5min)

- when should you call it?
	- is `for(in)` enough?
	- maybe you need asynchrony
	- or maybe you’re trying to compose it (mind the gap)

- how to call it
	- set up enumeration state
	- check for mutations

## Implementing it (10min)

- what to put in the state
	- fields are unsigned longs and pointers
		- Apple uses ILP32 and LP64, so unsigned longs are the same size as pointers
		- whole struct is 8 words long
			- 32 bytes on ILP32
			- 64 bytes on LP64
			- this small size helps make it size: good caching behaviour, good access times for sequential calculations, i.e. faster than `NSEnumerator`
	- documented as safe to cast the ptr to some type more appropriate to your needs *so long as the sizes suit*
	- it is technically possible to cast it to an object type; this is probably a terrible idea, but it can be done
		- if you do this, make sure no references to it are kept around, anywhere; it must not be autoreleased or you will die an ignominious death!
		- may not work on ARM64 anyway!

- if you have a contiguous C array of objects
	- set the mutations ptr; if you don’t have anything like this you can point it at some value you know won’t change, e.g. make it point at itself
	- set the items ptr to your internal storage
	- return your count

- if you have a discontiguous C array of objects (e.g. key/value pairs, like buckets in a hash table)
	- set the mutations ptr
	- set the items ptr to the buffer
	- set the state to the minimum of the buffer’s length and your remaining internal count
	- return that value
	- on next call, pick up from that # and carry on
	- make no assumptions about the contents of the buffer

## Limitations (10min)

- awkward (at best) memory management behaviour
- may not get any opportunity to clean up

- speed comes at the expense of memory management safety
	- `__unsafe_unretained` buffers mean nothing is retained → no overhead from `objc_retain`, but have to be *very* careful about what you assign
	- you can `-retain` & `-autorelease` objects (MRR) or dupe the language into doing it for you (ARC)	
		- but this makes the awkward assumption that the caller will either not call you from different autorelease pools or that it will assume ownership of the returned objects (which `__unsafe_unretained` says it will not do)
	- you can store the temporaries in an ivar somewhere and clean up when you do your final return
		- but you may never get the chance: `for(id x in y) {break;}`
	- better bet is to tie the lifetime of the temporaries to the object being enumerated, and only allow it to be enumerated once, a la `NSEnumerator`
		- or even just subclass `NSEnumerator`; this is exactly how it works, and you don’t have to implement `NSFastEnumeration` at all then, just `-nextObject`
	- thus, it’s hard to implement it for interesting behaviours when using ARC

- does not compose well
	- it’s hard to implement fast enumeration in terms of other fast enumerators
		- you have to manage the state yourself
		- you have to iterate the state yourself
			- no high-level API exists to do the equivalent of `for(in)` step by step (that’s kind of the point)

- therefore, maybe not the right API to use for expressing lazy evaluation (like generators)

- does not push

## Alternatives (10min)

- `NSFastEnumeration` is best used for serial, synchronous iteration of extant objects
	- best case is when the objects are already contiguous in memory
	- second best is when they’re owned and you can copy them into the buffer

- `NSEnumerator` still exists, and for good reason
	- conveniently encapsulates the one-by-one approach

- (recursive) enumeration of a linked list

- pushing via NSNotification, KVO, or delegation