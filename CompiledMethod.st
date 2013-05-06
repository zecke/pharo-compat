CompiledMethod extend [
    pragmas [
        | pragmas |

        "MIT licensed, written by Holger Hans Peter Freyther"
        "This is needed for Phexample but also Magritte3"
        <category: '*PharoCompat'>

        pragmas := WriteStream on: (Array new: self descriptor basicSize).
        1 to: self descriptor basicSize do: [:i |
            | msg pragma |
            msg := self descriptor at: i.
            pragma := Pharo.Pragma for: self selector: msg selector arguments: msg arguments.
            pragmas nextPut: pragma.
        ].

        ^pragmas contents
    ]
]
