BlockClosure extend [
    isBlock [
        <category: '*PharoCompat'>
        "For PhExample"
        ^true
    ]

    valueWithin: aDuration onTimeout: aBlock [
        <category: '*PharoCompat'>
        "For PhExample"
        ^(Delay forMilliseconds: aDuration asMilliseconds)
            value: self onTimeoutDo: aBlock
    ]
]
