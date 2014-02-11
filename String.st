String extend [
    expandMacros [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        ^self expandMacrosWithArguments: #()
    ]

    expandMacrosWith: anObject [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        ^self expandMacrosWithArguments: (Array with: anObject)
    ]

    expandMacrosWith: anObject with: anotherObject [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        ^self 
            expandMacrosWithArguments: (Array with: anObject with: anotherObject)
    ]

    expandMacrosWith: anObject with: anotherObject with: thirdObject [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        ^self expandMacrosWithArguments: (Array 
                with: anObject
                with: anotherObject
                with: thirdObject)
    ]

    expandMacrosWith: anObject with: anotherObject with: thirdObject with: fourthObject [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        ^self expandMacrosWithArguments: (Array 
                with: anObject
                with: anotherObject
                with: thirdObject
                with: fourthObject)
    ]

    expandMacrosWithArguments: anArray [
        <category: '*PharoCompat'>
        "From Pharo, for Phexample/OsmoCore, MIT license"
        | newStream readStream char index |
        newStream := (String new: self size) writeStream.
        readStream := self readStream.
        [ readStream atEnd ] whileFalse: 
            [ char := readStream next.
            char == $< 
                ifTrue: 
                    [ | nextChar |
                    nextChar := readStream next asUppercase.
                    nextChar == $N ifTrue: [ newStream nl ].
                    nextChar == $T ifTrue: [ newStream tab ].
                    nextChar isDigit ifTrue: 
                        [ index := nextChar digitValue.
            
                        [ readStream atEnd or: [ (nextChar := readStream next asUppercase) isDigit not ] ] whileFalse: [ index := index * 10 + nextChar digitValue ] ].
                    nextChar == $? ifTrue: 
                        [ | trueString falseString |
                        trueString := readStream upTo: $:.
                        falseString := readStream upTo: $>.
                        readStream position: readStream position - 1.
                        newStream nextPutAll: ((anArray at: index) 
                                ifTrue: [ trueString ]
                                ifFalse: [ falseString ]) ].
                    nextChar == $P ifTrue: [ newStream nextPutAll: (anArray at: index) printString ].
                    nextChar == $S ifTrue: [ newStream nextPutAll: (anArray at: index) ].
                    readStream skipTo: $> ]
                ifFalse: 
                    [ newStream nextPut: (char == $% 
                            ifTrue: [ readStream next ]
                            ifFalse: [ char ]) ] ].
        ^ newStream contents
    ]

    includesSubstring: aString caseSensitive: aCase [
        "Phexample unit testing"
        "MIT licensed"
        <category: '*PharoCompat'>

        ^(self indexOf: aString matchCase: aCase startingAt: 1) isNil not
    ]

    matchesRegex: aString [
        <category: '*PharoCompat'>
        ^self matchRegex: aString
    ]
]
