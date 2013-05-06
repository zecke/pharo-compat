TestCase subclass: TestPragma [
    | atPragma anotherAtPragma yetAnotherAtPragma atPutPragma |
    
    <category: 'KernelTests-Pragmas'>
    <comment: nil>

    setUp [
	<category: 'running'>
	atPragma := Pragma 
		    for: (Object methodDictionary at: #at:)
		    selector: #primitive:
		    arguments: (Array with: 60).
	anotherAtPragma := Pragma 
		    for: (Object methodDictionary at: #at:)
		    selector: #primitive:
		    arguments: (Array with: 60).
	yetAnotherAtPragma := Pragma 
		    for: (Object methodDictionary at: #at:)
		    selector: #primitive:
		    arguments: (Array with: 60).
	atPutPragma := Pragma 
		    for: (Object methodDictionary at: #at:)
		    selector: #primitive:
		    arguments: (Array with: 61)
    ]

    testCopy [
	<category: 'tests'>
	| copy |
	copy := atPragma copy.
	self deny: atPragma == copy.
	self assert: atPragma method == copy method.
	self assert: atPragma keyword == copy keyword.
	self assert: atPragma arguments == copy arguments
    ]

    testEqual [
	<category: 'tests'>
	self assert: atPragma = atPragma.	"Reflexivity"
	self assert: atPragma = anotherAtPragma.	"Simmetry"
	self assert: anotherAtPragma = atPragma.
	self assert: atPragma = anotherAtPragma.	"Transitivity"
	self assert: anotherAtPragma = yetAnotherAtPragma.
	self assert: yetAnotherAtPragma = atPragma.
	self deny: atPragma = atPutPragma
    ]

    testHash [
	<category: 'tests'>
	self assert: atPragma hash = atPragma hash.
	self assert: atPragma hash = anotherAtPragma hash.
	self assert: anotherAtPragma hash = atPragma hash.
	self assert: atPragma hash = anotherAtPragma hash.
	self assert: anotherAtPragma hash = yetAnotherAtPragma hash.
	self assert: yetAnotherAtPragma hash = atPragma hash
    ]
]

