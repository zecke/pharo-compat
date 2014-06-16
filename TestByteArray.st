TestCase subclass: TestByteArray [
    testHex [
        self assert: #[1 2 3] hex equals: '010203'.
    ]

    testHexParse [
        self assert: (ByteArray readHexFrom: '010203') equals: #[1 2 3].
        self assert: (ByteArray readHexFrom: 'AaBbCc') equals: #[170 187 204].
    ]
]
