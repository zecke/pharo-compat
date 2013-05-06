Object subclass: Pragma [
    | method keyword arguments |
    
    <category: 'PharoCompat'>
    <comment: 'I represent an occurrence of a pragma in a compiled method.  A pragma is a literal message pattern that occurs between angle brackets at the start of a method after any temporaries.  A common example is the primitive pragma:
	<primitive: 123 errorCode: ''errorCode''>
but one can add one''s own and use them as metadata attached to a method.  Because pragmas are messages one can browse senders and implementors and perform them.  One can query a method for its pragmas by sendng it the pragmas message, which answers an Array of instances of me, one for each pragma in the method.

I can provide information about the defining class, method, its selector, as well as the information about the pragma keyword and its arguments. See the two ''accessing'' protocols for details. ''accessing-method'' provides information about the method the pragma is found in, while ''accessing-pragma'' is about the pragma itself.

Instances are retrieved using one of the pragma search methods of the ''finding'' protocol on the class side.

To browse all methods with pragmas in the system evaluate
	SystemNavigation new browseAllSelect: [:m| m pragmas notEmpty]
and to browse all nonprimitive methods with pragmas evaluate
SystemNavigation new browseAllSelect: [:m| m primitive isZero and: [m pragmas notEmpty]]

NOTE: SystemNavigation does not exist in GNU Smalltalk.
'>

    Pragma class >> allNamed: aSymbol from: aSubClass to: aSuperClass [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol."

	<category: 'finding'>
	^Array streamContents: 
		[:stream | 
		aSubClass withAllSuperclassesDo: 
			[:class | 
			self withPragmasIn: class
			    do: [:pragma | pragma keyword = aSymbol ifTrue: [stream nextPut: pragma]].
			aSuperClass = class ifTrue: [^stream contents]]]
    ]

    Pragma class >> allNamed: aSymbol from: aSubClass to: aSuperClass sortedByArgument: anInteger [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol, sorted according to argument anInteger."

	<category: 'finding'>
	^self 
	    allNamed: aSymbol
	    from: aSubClass
	    to: aSuperClass
	    sortedUsing: [:a :b | (a argumentAt: anInteger) < (b argumentAt: anInteger)]
    ]

    Pragma class >> allNamed: aSymbol from: aSubClass to: aSuperClass sortedUsing: aSortBlock [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol, sorted according to aSortBlock."

	<category: 'finding'>
	^(self 
	    allNamed: aSymbol
	    from: aSubClass
	    to: aSuperClass) sort: aSortBlock
    ]

    Pragma class >> allNamed: aSymbol in: aClass [
	"Answer a collection of all pragmas found in methods of aClass whose keyword is aSymbol."

	<category: 'finding'>
	^Array streamContents: 
		[:stream | 
		self withPragmasIn: aClass
		    do: [:pragma | pragma keyword = aSymbol ifTrue: [stream nextPut: pragma]]]
    ]

    Pragma class >> allNamed: aSymbol in: aClass sortedByArgument: anInteger [
	"Answer a collection of all pragmas found in methods of aClass whose keyword is aSymbol, sorted according to argument anInteger."

	<category: 'finding'>
	^self 
	    allNamed: aSymbol
	    in: aClass
	    sortedUsing: [:a :b | (a argumentAt: anInteger) < (b argumentAt: anInteger)]
    ]

    Pragma class >> allNamed: aSymbol in: aClass sortedUsing: aSortBlock [
	"Answer a collection of all pragmas found in methods of aClass whose keyword is aSymbol, sorted according to aSortBlock."

	<category: 'finding'>
	^(self allNamed: aSymbol in: aClass) sort: aSortBlock
    ]

    Pragma class >> for: aMethod selector: aSelector arguments: anArray [
	<category: 'instance creation'>
	^(self new)
	    setMethod: aMethod;
	    setKeyword: aSelector;
	    setArguments: anArray;
	    yourself
    ]

    Pragma class >> keyword: aSymbol arguments: anArray [
	<category: 'private'>
	^(self new)
	    setKeyword: aSymbol;
	    setArguments: anArray;
	    yourself
    ]

    Pragma class >> withPragmasIn: aClass do: aBlock [
	<category: 'private'>
	aClass 
	    selectorsAndMethodsDo: [:selector :method | method pragmas do: aBlock]
    ]

    method [
	"Answer the compiled-method containing the pragma."

	<category: 'accessing-method'>
	^method
    ]

    methodClass [
	"Answer the class of the method containing the pragma."

	<category: 'accessing-method'>
	^method methodClass
    ]

    selector [
	"Answer the selector of the method containing the pragma.
	 Do not confuse this with the selector of the pragma's message pattern."

	<category: 'accessing-method'>
	^method selector
    ]

    argumentAt: anInteger [
	"Answer one of the arguments of the pragma."

	<category: 'accessing-pragma'>
	^self arguments at: anInteger
    ]

    arguments [
	"Answer the arguments of the receiving pragma. For a pragma defined as <key1: val1 key2: val2> this will answer #(val1 val2)."

	<category: 'accessing-pragma'>
	^arguments
    ]

    key [
	"Answer the keyword of the pragma (the selector of its message pattern).
	 This accessor provides polymorphism with Associations used for properties."

	<category: 'accessing-pragma'>
	^keyword
    ]

    keyword [
	"Answer the keyword of the pragma (the selector of its message pattern).
	 For a pragma defined as <key1: val1 key2: val2> this will answer #key1:key2:."

	<category: 'accessing-pragma'>
	^keyword
    ]

    message [
	"Answer the message of the receiving pragma."

	<category: 'accessing-pragma'>
	^Message selector: self keyword arguments: self arguments
    ]

    numArgs [
	"Answer the number of arguments in the pragma."

	<category: 'accessing-pragma'>
	^self arguments size
    ]

    = aPragma [
	<category: 'comparing'>
	self == aPragma ifTrue: [^true].
	self species == aPragma species ifFalse: [^false].
	self method = aPragma method ifFalse: [^false].
	self keyword = aPragma keyword ifFalse: [^false].
	self arguments = aPragma arguments ifFalse: [^false].
	^true
    ]

    analogousCodeTo: anObject [
	<category: 'comparing'>
	^self class == anObject class 
	    and: [keyword == anObject keyword and: [arguments = anObject arguments]]
    ]

    hash [
	<category: 'comparing'>
	| hash |
	hash := self method hash bitXor: self keyword hash.
	1 to: self basicSize
	    do: [:index | hash := hash bitXor: (self basicAt: index) hash].
	^hash
    ]

    setArguments: anArray [
	<category: 'initialization'>
	arguments := anArray
    ]

    setKeyword: aSymbol [
	<category: 'initialization'>
	keyword := aSymbol
    ]

    setMethod: aCompiledMethod [
	<category: 'initialization'>
	method := aCompiledMethod
    ]

    printOn: aStream [
	<category: 'printing'>
	aStream nextPut: $<.
	self keyword precedence = 1 
	    ifTrue: [aStream nextPutAll: self keyword]
	    ifFalse: 
		[self keyword keywords with: self arguments
		    do: 
			[:key :arg | 
			aStream
			    nextPutAll: key;
			    space;
			    print: arg;
			    space].
		aStream skip: -1].
	aStream nextPut: $>
    ]

    sendTo: anObject [
	"Send the pragma keyword together with its arguments to anObject and answer the result."

	<category: 'processing'>
	^anObject perform: self keyword withArguments: self arguments
    ]

    withArgumentsDo: aBlock [
	"Pass the arguments of the receiving pragma into aBlock and answer the result."

	<category: 'processing'>
	^aBlock valueWithArguments: self arguments
    ]

    hasLiteralSuchThat: aBlock [
	"Answer true if litBlock returns true for any literal in the receiver, even if embedded in further array structure.
	 This method is only intended for private use by CompiledMethod hasLiteralSuchThat:"

	<category: 'testing'>
	^(aBlock value: keyword) or: [arguments hasLiteralSuchThat: aBlock]
    ]

    hasLiteral: aLiteral [
	<category: 'testing'>
	^keyword == aLiteral or: [arguments hasLiteral: aLiteral]
    ]
]

