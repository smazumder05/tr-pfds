#lang scribble/manual

@(require scribble/eval)

@(define evaluate (make-base-eval))
@(evaluate '(require typed/scheme))
@(evaluate '(require "../stream.ss"))

@title[#:tag "streams"]{Streams}

Streams are nothing but lazy lists. They are similar to ordinary
lists and they provide the same functionality as that of lists. The 
difference between Streams and lists is that they are lazy in nature and 
each cell of a Stream is suspended and is forced only when required. Streams 
have been used in some of the below mentioned data structures. Since
each suspention comes with a little overhead, Streams should be used
only when there is a good enough reason to do so.

@section{Stream Constructor and Operations}

@subsection{stream}
The function stream creates a Stream with the given inputs. 

@examples[#:eval evaluate

(stream 1 2 3 4 5 6)
]

In the above example, the stream obtained will be similar to lists but will
lazy in nature. It will have 1 as its first element.

@subsection{empty-stream}
A empty stream

@subsection{empty-stream?}
The function @scheme[empty-stream?] takes a Stream checks if the given stream is 
empty. 
@examples[#:eval evaluate

(empty-stream? (stream 1 2 3 4 5 6))
(empty-stream? empty-stream)

]


@subsection{stream-cons}
The function @scheme[stream-cons] takes an element and a stream and adds 
the given element to the given stream. 
@examples[#:eval evaluate

(stream-cons 10 (stream 1 2 3 4 5 6))
]

In the above example, @scheme[(stream-cons 10 (stream 1 2 3 4 5 6))] 
returns the stream @scheme[(stream 10 1 2 3 4 5 6)].


@subsection{stream-car}
The function @scheme[stream-car] takes a stream and returns the first element
of the given stream. If the given stream is empty, then it throws an error.

@examples[#:eval evaluate

(stream-car (stream 1 2 3 4 5 6))
(stream-car empty-stream)
]


@subsection{stream-cdr}
The function @scheme[stream-cdr] takes a stream and returns the same stream 
but without the first element of the given stream. 
@examples[#:eval evaluate

(stream-cdr (stream 1 2 3 4 5 6))
(stream-cdr empty-stream)
]

In the above example, @scheme[(stream-cdr strm)] returns 
@scheme[(stream 2 3 4 5 6)].


@subsection{stream-append}
The function @scheme[stream-append] takes two streams and creates a new 
stream by appending the second stream to the end of first stream. 

@examples[#:eval evaluate

(define strm1 (stream 1 2 3 4 5 6))

(define strm2 (stream 51 32 42))

(stream-append strm1 strm2)
]

In the above example, @scheme[(stream-append strm1 strm2)] returns the stream,
@scheme[(stream 1 2 3 4 5 6 51 32 42)].


@subsection{stream-reverse}
The function @scheme[stream-reverse] takes a streams and gives a reversed
stream back. 
@examples[#:eval evaluate

(stream-reverse (stream 1 2 3 4 5 6))
]

In the above example, @scheme[(stream-reverse (stream 1 2 3 4 5 6))] returns
@scheme[(stream 6 5 4 3 2 1)].


@subsection{stream->list}
The function @scheme[stream->list] takes a stream and returns a list
of elements which are in the same order as in the stream. 
@examples[#:eval evaluate

(stream->list (stream 1 2 3 4 5 6))
(stream->list empty-stream)
]


@subsection{drop}
The function @scheme[drop] takes an integer(say n) and a stream and creates a
new stream which is same as the given stream but without the first n elements
of the input stream. If the number of elements in the given stream is less 
than n, then @scheme[drop] throws an error.

@examples[#:eval evaluate

(drop 3 (stream 1 2 3 4 5 6))
(drop 10 (stream 1 2 3 4 5 6))
]

In the above example, @scheme[(drop 3 (stream 1 2 3 4 5 6))] returns 
@scheme[(stream 4 5 6)].



@subsection{take}
The function @scheme[take] takes an integer(say n) and a stream and creates a
new stream with the first n elements of the input stream. If the number of 
elements in the given stream is less than n, then @scheme[take] throws an 
error. 
@margin-note{@scheme[(take 5 (stream 1))] does not
throw any error because @scheme[take] returns a suspension rather than 
finishing the whole computation.}
@examples[#:eval evaluate

(take 3 (stream 1 2 3 4 5 6))
(take 5 (stream 1))
]

In the above example, @scheme[(take 3 (stream 1 2 3 4 5 6))] returns
@scheme[(stream 1 2 3)].