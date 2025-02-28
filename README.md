PCBmerge 

PCB Merge is a tool for Altium Designer that let's you merge changes between PCB layouts. This allows multiple people to work in one project.
Altium has built-in collaboration tools and this is NOT a replacement for these. It serves a different function.

PCBmerge allows you to
- read the X/Y/rotation/layer from selected parts and/or designators from a source board
- respect/ignore/copy/force locks on components for source and target
- Apply the data to the target board

 It does NOT copy objects. the objects need to exists. It brings over the positional data and applies it.

 Example :
 A design has all parts loaded in a master PCB document ready for place and route to begin.
 Two people are working on the same board, each in their own area and in their own copy of this master file
 At the end of the day a merge needs to happen.
 In turn, each designer opens tha master file , runs the tool to select his block of placed parts and applies the changes to master file.
 The copper features are brought over by using a simply copy-paste.

 Why not copy the components ? 
 Internally, Altium has links between PCB and schamtic. Bringing over the components breaks those links and creates all kinds of trouble.
 This tool works on the existing footprints.








Released under MIT Licenes   https://opensource.org/license/mit

  MIT License

  Copyright 2024 Vincent Himpe
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
  files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy,
  modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
