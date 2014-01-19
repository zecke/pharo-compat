TestCase subclass: TestBlockClosure [
    <category: 'PhatoCompat-Tests'>

    testIsBlock [
        | a|
        a := [].
        self assert: a isBlock.
    ]

    testValueWith [
        | res |
        res := [(Delay forSeconds: 999999) wait. false]
                    valueWithin: 10 milliSeconds onTimeout: [true].
        self assert: res
    ]
]
