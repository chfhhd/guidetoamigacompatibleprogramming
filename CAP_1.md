# Introduction

*"There is a insurmountable problem. Which is not about the ego of someone or
the commercial and industrial projects. It's simply the litigiosity of the
community. We knows, amigans were always fractious like soccer supporters.
When they lived at home with mum who checked at what time they were back to home
and if they were studiyng, things went well. But when they become independent,
they made only messes."* 
Alfonso "alfie" Ranieri, ATML, 10/12/2007


## 1.1 Problems to face when programming on Amiga

There are a multitude of problems for a new Amiga programmer:

1) Lack of a good documentation;
2) Lack of modern tools for application development;


Most of the documentation on Amiga systems that is available is outdated,
mostly in English, and with a lot of obsolete parts. Throughout this guide we will
address the reader to resources still valid in the world of the Amiga
reincarnations. In systems such as Windows, MacOSX and Linux there are IDEs (Integrated 
Development Enviroment) with marvelous features, these programs give the users
everything they need to develop software in the simplest and fastest way possible.
Unfortunately, the Amiga platform doesn't offer this anymore, except for one IDE,
CubicIDE, which offers a lot of features which are present in modern IDEs. By
the way, CubicIDE is a pay for use software (at this time, the user licence is
about 100 euros, an amount of money which is not always available to students
and beginners programmers...), and this software offers guaranteed support
only for AmigaOS3.x and MorphOS. So, there isn't any version for AROS.
In this guide we'll refer to possible alternatives in the little Amiga universe
concerning advanced editors. By the way, the biggest problem above all of
these problems: the amiga mentality.


## 1.2 Past and modern philosophies: reset course

Amiga was born in the 80s, it amazed everyone with its features... If you still
don't know much about this, we suggest you read up on it's history, just
to understand some good points about the Amiga platform. The user/programmer who
is starting a new software project have a valuable cultural and philosophical
background, which is the direct product of the trouble his beloved platform
went through. This means that some of its ideas should be perfectly shareable if
we were in the second half of the 80s, but are completely obsolete if applied
in the 21st century. In particular, the amiga philosophies provide:

1) Lack of a definite design: the programmer starts to code without any
planning of what he's going to write;

2) Not reusing the available resources: they often develop a software which
offers 4 or 5 features identical to already available software. So they often
"reinvent the wheel" by not using already available APIs, but rewriting them
from scratch instead.

3) "Closed" source: the programmer writes the code considering himself as the
only developer able to carry on the project. This code is not written for
public release, it doesn't have any comprehensive documentation for those who
read the code in the future, there are poor comments and the order of function
writing is not always understandable;

4) Lack of collaboration: an Amiga program is often developed by a single coder,
it's very difficult to see two or more Amiga programmers collaborate on the
same software.

5) Lack of portability: the programmer believes that his own system will last
forever, it's the only valid system ("OS4 is better! No MOS is better!") and
will never change. For this reason the code is written in a coder's platform
dependent way. 

6) Focus on assembly optimizations: the lack of the design phase causes the
writing of code with non-robust algorythms and, in order to improve software
efficiency, the amiga developer prefers to use assembly language.

It's futile to repeat that the above conventions are (in almost all cases) 
wrong and bring nothing good to the amiga platform. 21st century
software (those that are absent on amiga and that all users need) are
developed in this way instead:

1) Problem analysis and resolution: to develop a software, we first analize
the problems it must solve. This analysis consists of a series of phases
that will define the work to be done to develop the software without any
ambiguity.

2) Respect of quality rules: there are procedures and metrics to guarantee
the quality of some features of a software, for example reusability and maintainability
(= see point 6). Reusability means the reuse of functions and/or modules
already written, so the programmer doesn't need to reimplement such features
from scratch. This leads to lower production times and higher program
reliability, because third party modules are reused in other softwares too,
being tested and gaining robustness.

3) "Open" code: code is written keeping in mind that it should be understood
by someone who has no idea what he's reading. This means that the code
should have plenty of documentation and plenty of comments inside the code itself. 
Code is always written following the same order and considered a public release.

4) Using of more human resources to develop software: groups of people can
collaborate on the same software. To obtain this, code standards are defined
(such as how to indent code, how to insert comments etc...), and code sharing
tools, such as svn, are used.

5) Portability: it's useless to define the portability meaning, just
see projects such as Firefox and Openoffice, or independent programming
language such as Java;

6) Maintenance: it's a microanalysis phase, in which we try to maintain
"alive" the software we developed. In this phase, we can fix bugs (corrective
maintenance), add new features (adaptive maintenance) and optimize some
parts of the software (perfective maintenance). This phase derives directly
from the above points, because the maintenance process can require a huge
resource expense if the software wasn't well thought out or the code wasn't
well written, sometimes this leads to the dismissal of the software itself.


## 1.3 What is the Amiga platfrom today? Hints to code portability...

This chapter should appear difficult to who have never used Amiga or have
never developed with it's APIs. Reader's doubts should disappear following
this guide, so don't worry if you don't understand something initially.

What is the Amiga platfrom? We have to summarize in a single sentence more
than twenty years of Amiga history, so we'll be concise: today, the Amiga
platform is the combination of four operating systems seemingly independent,
whose longevity is intrinsically connected. We refer to the following operating
systems:

- AmigaOS3: http://en.wikipedia.org/wiki/AmigaOS_versions
- AmigaOS4: http://en.wikipedia.org/wiki/AmigaOS_versions
- MorphOS: http://en.wikipedia.org/wiki/MorphOS
- AROS: http://en.wikipedia.org/wiki/AROS_Research_Operating_System

Due to the conditions in which these Amiga flavours live, we must think
about the reasons we would want to develop something for only one of those
amiga flavours, while we could do it for all of them. If our goal is to
write software for the Amiga platform and the platform is the result of
the combination of these four incarnations, we shouldn't exclude any of
them. Any incarnation could prevail over the others for some reason and
our software wouldn't have some systems to run on, in other words, our
software could unwisely became a non-Amiga software. The chance to run
on more than one amiga flavor makes the software more complete: more
support for different platforms brings in a larger user base and, therefore,
more feedback and testing on its features. This brings a growth of
robustness, reliability, completeness and efficiency on the program being
developed... Writing "Amiga multiplatform" code is not as difficult as it would
appear, but we must follow some tips:

1) MUI: 
    http://aminet.net/dev/mui/mui38dev.lha ; 

    First of all, the choice of an API to build a modern graphic interface
    (in which we don't need to reimplement basic gadgets from scratch or
    to define procedures for element placement - Layout - or struggle to
    understand how to "interconnect" graphical objects) must be MUI, or
    Magic User Interface, instead of other solutions. The MUI API is
    available for all Amiga flavours, this is what makes MUI a must.

2) SDI: 
    http://sourceforge.net/projects/sditools/ ; 
    
    Every amiga reincarnation has extended the AmigaOS3.1 APIs in different ways.
    So, in every reincarnation there is a common API group, an updated and
    incompatible API group and some new APIs incompatible and probably absent
    from one incarnation to another. Regarding the second point, some AmigaOS 3.x
    peculiarities, such as BOOPSI classes' dispatcher implementation, the callback
    hook system etc... are different from one incarnation to another. To write
    compatible software some macros are available, they are called SDI tools.
    Using SDI we can write libraries and other vital parts of our software in a
    portable way, without knowing how a single thing was reimplemented in AROS or
    in AmigaOS4, but only knowing the common parts.


3) Isolated conditional code:

    We've just realized that there are new features in every amiga reincarnation which
    could be absent in the others. If you want to use these new APIs we suggest to
    use conditional code (in C language such code is marked between the following
    instruction: #ifdef, #elif, #else, #endif), inside the vital functions of the
    software, or to isolate such parts in functions and/or separate files to include
    in the compilation for only one incarnation or the another.

In the open source and freely readable amiga software we can find Yam, SimpleMail,
Scout, and the MUI classes TextEditor, BetterString, NListxxx. All of these programs,
used by all Amiga users, are developed with the above three points in mind.
