TestCase subclass: TestSet [
    <category: 'PharoCompat-Tests'>

    testUnion [
        | set1 set2 res |
        set1 := Set new add: 'A'; add: 'B'; yourself.
        set2 := Set new add: 'B'; add: 'C'; yourself.
        res := set1 union: set2.
        self assert: res size = 3.
        self assert: (res includes: 'A').
        self assert: (res includes: 'B').
        self assert: (res includes: 'C').
    ]
]
