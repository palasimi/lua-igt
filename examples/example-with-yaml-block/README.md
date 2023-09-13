---
title: Example
header-includes: >
  <style>
      .igt {
          margin: 1em 2em;
      }
      .igt-label {
          font-variant: small-caps;
          text-decoration: underline dashed;
          text-transform: lowercase;
      }
  </style>
glossing-abbreviations:
  1SG: first person singular
  3NSG: third person nonsingular
  NPST: nonpast
...

## Instructions

Compile this file by following these instructions.
The first step is to [build the pandoc filter](../../CONTRIBUTING.md).
Alternatively, you may grab a copy from [GitHub](https://github.com/palasimi/lua-igt/releases).
Save it as `build/filter.lua` (from the project's root directory).
Then run the following command in the same directory as this file you're reading:

```bash
pandoc README.md -s --lua-filter ../../build/filter.lua
```

## Source

~~~markdown
```gloss
ne-e a-khim-chi n-yuNNa
DEM-LOC 1SG.POSS-house-PL 3NSG-be.NPST
'Here are my houses.'
```
~~~

## Output

```gloss
ne-e a-khim-chi n-yuNNa
DEM-LOC 1SG.POSS-house-PL 3NSG-be.NPST
'Here are my houses.'
```

(Example taken from [The Leipzig Glossing Rules](https://www.eva.mpg.de/lingua/resources/glossing-rules.php))
