module Tests.Invariants exposing (..)

import ArchitectureTest exposing (..)
import Array.Hamt as Array
import Expect exposing (Expectation)
import Main exposing (..)
import Test exposing (..)
import Tests.Common exposing (..)


positionLineIsAlwaysPositive : Test
positionLineIsAlwaysPositive =
    invariantTest "position.line is always positive" app <|
        \_ _ finalModel ->
            finalModel.position.line
                |> Expect.atLeast 0


positionLineNeverGetsToNonexistingLine : Test
positionLineNeverGetsToNonexistingLine =
    invariantTest "position.line never gets to nonexisting line" app <|
        \_ _ finalModel ->
            finalModel.position.line
                |> Expect.atMost (lastLine finalModel.lines)


positionColumnIsAlwaysPositive : Test
positionColumnIsAlwaysPositive =
    invariantTest "position.column is always positive" app <|
        \_ _ finalModel ->
            finalModel.position.column
                |> Expect.atLeast 0


positionColumnNeverGetsMoreThanOneCharAfterLineContents : Test
positionColumnNeverGetsMoreThanOneCharAfterLineContents =
    invariantTest "position.column never gets more than one char after line contents" app <|
        \_ _ finalModel ->
            finalModel.position.column
                |> Expect.atMost
                    (lastColumn
                        finalModel.lines
                        finalModel.position.line
                    )


linesArrayNeverEmpty : Test
linesArrayNeverEmpty =
    invariantTest "lines array never empty" app <|
        \_ _ finalModel ->
            finalModel.lines
                |> Array.length
                |> Expect.atLeast 1