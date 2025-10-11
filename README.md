# Sauco Profiler

[![Test](https://github.com/tinchodias/pharo-sauco-profiler/actions/workflows/test.yml/badge.svg)](https://github.com/tinchodias/pharo-sauco-profiler/actions/workflows/test.yml)

A tool to help in the comprehension of profilers' output, in Pharo. 

This project provides:
- A model to aggregate the tally information from the `MessageTally` and `AndreasSystemProfiler` (See `SaMethodNode`, `SaBehaviorNode` and `SaCategoryNode`).
- Spec2 inspectors provide means to explore the model.
- Color mappings for the model and visualizations, such as a [flame graph](https://github.com/brendangregg/FlameGraph), which is a kind of non-radial [Sunburst](https://www.data-to-viz.com/graph/sunburst.html). The intention is easing comprehension of the tally nodes output. See captures below.

## Screenshots

| Tally Tree | Behaviors (Classes, Metaclasses, Traits |
:-----------:|:---------------------------------------:|
<img width="478" alt="TallyTree" src="https://user-images.githubusercontent.com/3044265/140250604-582909e6-0b0a-49bf-9808-e7c4958bf608.png"> | <img width="539" alt="Classes" src="https://user-images.githubusercontent.com/3044265/140250800-1d169be5-463c-4564-af9d-871533324180.png">



| Flame Graph (macro view) | Flame Graph (zoomed view) | Color Mapping by category |
:-------------------------:|:-------------------------:|:--------------------------:
| <img width="361" alt="SkiaMacro" src="https://user-images.githubusercontent.com/3044265/140248163-caf41ef3-80e2-434b-8dfd-823ec3dd17b5.png"> | <img width="749" alt="CairoDetail" src="https://user-images.githubusercontent.com/3044265/140248169-e4146666-d052-4617-a2e5-8af14929fc47.png"> | <img width="108" alt="Legend" src="https://user-images.githubusercontent.com/3044265/140248298-24c7dba1-92c7-4e84-b192-f1f84faefdec.png">  |


## Install

Evaluate the following script in a Pharo image (>=v13):
~~~smalltalk
Metacello new
    baseline: 'Sauco';
    repository: 'github://tinchodias/pharo-sauco-profiler:master/src';
    load.
~~~

## How to Use

You can find several examples oof use in class-side of `SaReport`, such as:
```Smalltalk
SaReport exampleUUID
```

But you can just place code to profile in a block closure and inspect the `SaReport` like:
```Smalltalk
SaReport newWithASPOn: [ 
	| array |
	array := FLSerializer serializeToByteArray: Smalltalk ui icons. 
	FLMaterializer materializeFromByteArray: array ]
```

## License

The code is licensed under [MIT](LICENSE).

## What is the *sauco* word? 

Sauco is a name of [a tree](https://es.wikipedia.org/wiki/Sambucus_australis). One of the variants has fruits like these:

![Fruits](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Sambucus_nigra2.jpg/320px-Sambucus_nigra2.jpg)
