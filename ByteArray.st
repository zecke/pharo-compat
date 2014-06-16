ByteArray extend [
    hex [
        <category: '*PharoCompat'>
        " an alternate implementation was | result stream |
        result := String new: self size * 2.
        stream := result writeStream.
        1 to: self size do: [ :ix | |each|
            each := self at: ix.
            stream
                nextPut: ('0123456789ABCDEF' at: each // 16 + 1);
                nextPut: ('0123456789ABCDEF' at: each \\ 16 + 1)].
        ^ result"
        
        "Answer a hexa decimal representation of the receiver"
        | string v index map |
        map := '0123456789abcdef'.
        string := String new: self size * 2. "hex"
        index := 0.
        1 to: self size do: [ :i |
            v := self at: i.
            string at: (index := index + 1) put: (map at: (v bitShift: -4) + 1).
            string at: (index := index + 1) put: (map at: (v bitAnd: 15) + 1)].
        ^string
    ]

    readHexFrom: aStream [
        <category: '*PharoCompat'>

        "Initialize the receiver from a hexadecimal string representation"
        | map v ch value |
        map := '0123456789abcdefABCDEF'.
        1 to: self size do: [ :i |
            ch := aStream next.
            v := (map indexOf: ch) - 1.
            ((v between: 0 and: 15) or: [((v:= v - 6) between: 0 and: 15)])
                ifFalse:[^self error: 'Hex digit expected'].
            value := v bitShift: 4.
            ch := aStream next.
            v := (map indexOf: ch) - 1.
            ((v between: 0 and: 15) or: [((v:= v - 6) between: 0 and: 15)])
                ifFalse:[^self error: 'Hex digit expected'].
            value := value + v.
            self at: i put: value].
    ]
]

ByteArray class extend [
    readHexFrom: aString [
        <category: '*PharoCompat'>
        "Create a byte array from a hexadecimal representation"
        ^(self new: aString size // 2) readHexFrom: aString readStream
    ]
]

