TestCase subclass: TestByteArray [
    testHex [
        self assert: #[1 2 3] hex equals: '010203'.
    ]
]
