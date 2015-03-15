# Basic knowledge for Amiga programming

"AmigaOS is a microkernel message-passing design, with better response time
and performance than any other readily available PC operating system: including
MINIX, OS/2, Windows, MacOS, Linux, UNIX, and *certainly* MS-DOS.

The microkernel design has proven invaluable. Things like new file systems
that are normally available only from the vendor are hobbyist products on
the Amiga. Device drivers are simply shared libraries and tasks with specific
entry points and message ports. So are file systems, the window system, and
so on. It's a WONDERFUL design, and validates everything that people have
been saying about microkernels. Yes, it takes more work to get them off the
ground than a coroutine based macrokernel like UNIX, but the versatility
pays you back many times over."
        
Peter Da Silva, The Tanenbaum-Torvalds Debate, 07/02/1992


## 3.1 Excursus (discussion) on Amiga OS

Introducing programming concepts starting from scratch is very hard: you are
never sure if a concept has been explained in a clear way and if it's better to
discuss a particular theory before or after another one. Let's try to proceed by
applying some base rules for the understanding of this and following chapters:

- To know the basics of C language;
- To know the basics of operating systems;

All Amiga APIs are designed to be used with C language, or even 68k assembly if
on OS3.x, but since we are in 21st century it's better to focus on the most
famous medium-level language that everyone has heard at least talked about once.
Assuming that you have mastery of concepts such as functions, pointers,
structures, casting, API (Application Programming Interface) etc... Let's
introduce some amiga related concepts.


## 3.2 Inside AmigaOS

All Amiga flavors have AmigaOS3.1 as their common root, so a little look to the
90s of AmigaOS is needed. AmigaOS is a monouser multiprogrammed operating system,
mainly built on three important components:

- An atypical microkernel called MultitaskingExecutive (Exec); 
- AmigaDOS;
- Intuition;

And there are other more or less relevant modules.

Exec is AmigaOS's microkernel. Exec's job is to handle the whole system and
its resources, running programs (called tasks), message ports and many other
things.

AmigaDOS is the module that handles AmigaOS's I/O and offers:

- A command line interface;
- Processes: the tasks that can use particular functions;
- Filesystem related APIs, which organizes datas on storage devices. On AmigaOS
  a filesystem is a process, used by applications to communicate through
  message exchange.

Intuition provides AmigaOS graphical objects to interact with the user.
Although AmigaOS's graphical interface has intuition as its core, there are
other tools, built on intuition, that allow you to build GUIs quickly:

- GadTools, should ease the making of new gadgets and menus;
- ASL, allows an easier making of Requesters;
- BOOPSI, allows you to extend and improve Intuition through the object oriented
  technique (OOP). BOOPSI is essentially a collection of classes to build
  graphical objects;
- Workbench, a system program that uses graphical symbols, called icons, useful
  to interact with the filesystem offered by AmigaOS;

AmigaOS is, more generally, organized following an overlapped modules hierarchy;
starting from the lower modules we have:

- resource: a collection of low level functions that allow direct access to the
  system hardware;
- device: a collection of functions that control character and block I/O devices
  and, more generally, all available hardware using AmigaOS IPC tecnique;
- library: collection of functions for different uses;
- system programs;

Libraries are organized according to a hierarchy of levels, following the set
of functions that they collect; in fact there are groups of functions that work
in a lower level than other groups. Devices and resources don't have the same
organization, because each of them handles the devices for which it was designed.
Libraries are used for most of the tasks to be performed, devices and resources
are only used in particular cases. Such design makes AmigaOS a modular Operating
System, giving the opportunity to extend and update its features without
interfering with existing applications.


## 3.3 Using Amiga functions

Every program that uses the functions of an operating system, here AmigaOS and
spin-offs, must be able to access such APIs. On AmigaOS, using library functions,
devices and so on, means making available such modules to the application. For
this reason we need the opening process of one or more libraries at the
beginning of every program.

On AmigaOS there is always a library opened: exec.library, which offers the
functions that exec provides to the programmer. For example, if we want to
create a requester, using the EasyStruct structure, defined in \<intuition/intuition.h> : 

```c
struct EasyStruct {
    ULONG es_StructSize;    /* structure dimentsion                */
    ULONG es_Flags;         /* usually set to 0                    */
    UBYTE *es_Title;        /* requester's title                   */
    UBYTE *es_TextFormat;   /* string inside the requester         */
    UBYTE *es_GadgetFormat; /* string inside the close button      */
};
```

and the Intuition's EasyRequestArgs() function, declared in this way:


```c
LONG EasyRequestArgs(struct Window *window,               /* window which the  */
                                                          /* requester belongs */
                                                          /* to;               */
                              
                     CONST struct EasyStruct *easyStruct, /* requester to      */
                                                          /* open;             */
                     LONG *idcmpPtr,                      /* a particular      */
                                                          /* event that closes */
                                                          /* the requester     */
                     CONST APTR args );                   /* optional          */
                                                          /* arguments...;     */
```                                                          

we have to open intuition.library first. To perform this task Exec's function
calls OpenLibrary(). When we close the program we need to close all the
libraries we opened at the beginning of the program itself, so we use CloseLibrary()
to do this. Summarizing, in our example we'll have a situation like this:

```c
/*****************************************************************************/
#include <stdio.h>
#include <proto/exec.h>
#include <proto/intuition.h>

struct IntuitionBase *IntuitionBase;

int main(void)
{
  IntuitionBase=(struct IntuitionBase *) OpenLibrary("intuition.library",39);

  if (!IntuitionBase)
    return 0;
  
  struct EasyStruct requester;
  
  requester.es_StructSize   = sizeof(struct EasyStruct);
  requester.es_Flags        = 0;
  requester.es_Title        = "Example requester";
  requester.es_GadgetFormat = "Exit";
  requester.es_TextFormat   = "This is a try!";
  EasyRequestArgs(NULL, &requester, NULL, NULL);

  if (IntuitionBase)
    CloseLibrary((struct Library *)IntuitionBase);
  
  return 0;
}
/*****************************************************************************/
```

To use library functions, a program needs a pointer to the library's data area,
stored somewhere in memory, such area is called "Base". The base of an
OpenLibrary() returned library is nothing more than a structure having its own
name (to know the name of the Base of a function, see header protos of the same
functions). OpenLibrary() takes the name of the library to open and its minimum
version as arguments. If the system cannot find the library we requested or
find a previous version that is specified, OpenLibrary() would return NULL.

As we said, the first parameter of OpenLibrary() is the name of the library,
such library might already be in memory, in this case OpenLibrary() will open
the resident library, anyway, our library might not yet be resident in memory.
In this case, OpenLibrary() will refer to the "LIBS:" device (which is usually
an assign to Sys:Libs/) to find the library, load it into memory and open it. If
you want to specify a different path than "LIBS:", you'll have to insert the
path with the name of the library as first parameter of OpenLibrary(), for
example:

```c
OpenLibrary("sys:foo/bar.library", 0);
```

In this way we open any version of bar.library resident in sys:foo/. Although
AmigaOS id case insensitive, Exec's functions are not case insensitive, so you
need to be careful with uppercase and lowercase letters of names specified to
OpenLibrary().

The data area of a library is called Base because it specifies the lower part of the
memory reserved to a particular library. Before the Base, or if we want "above"
the base, there is another structure called functions table. Functions table 
contains references to all the functions a library provides. The program
essentially browses the functions table to find the one which was invoked.
After being sure to have a pointer to the Base of the library we are interested
in, we can use the functions offered by the library. It's important to note
that AmigaOS needs the programmer to expressly close the library, to perform it
the CloseLibrary() function is used.

Due to the number of libraries used normally in a program, it's common practice
to put the processes of opening and closing libraries inside two different
functions, which respectively open and close all the libraries we'll use in our
program.


### 3.3.1 AmigaOS4 interfaces and Amiga OS's preprocessor symbols.

AmigaOS4 introduces some changes relating the access of library functions. In
the previous paragraph we learned how a program needs to get the Base of a
library to access its functions. Using the Base the program gains the capability
to access the table of functions of the corresponding library. On AmigaOS4 a new
version of shared libraries has been introduced, called "interfaces". On AmigaOS4
it is still not possible to access directly the library functions simply opening it
with OpenLibrary(), you'll need to specify first which interface contains the
functions we'll refer to. Basic functions of a library are pointed to from the
"main" interface, on OS4 even the AmigaOS3.x APIs are accessible through this
interface. So, while on AmigaOS3.x we only needed to get access to the Base of
a function with OpenLibrary(), on AmigaOS4 we'll also need to access the interface of
the library, "main" in our case. To obtain all these things there are two new
functions in ExecSG (the new AmigaOS4 kernel), called GetInterface() and 
DropInterface(), used respectively to open and close an interface. The previous
paragraph's example become the following:

```c
/*****************************************************************************/
#include <proto/exec.h>
#include <proto/intuition.h>

struct Library *IntuitionBase;
struct IntuitionIFace *IIntuition;

int main(void)
{
  IntuitionBase= (struct Library *) IExec->OpenLibrary("intuition.library",39);

  if (!IntuitionBase)
    return 0;
  
  IIntuition = (struct IntuitionIFace *) IExec->GetInterface(IntuitionBase, 
                                 "main", 1, NULL);
  
  if (!IIntuition)
  {
    IExec->CloseLibrary((struct Library *)IntuitionBase);
    return 0; 
  }             
  
  struct EasyStruct requester;
  
  requester.es_StructSize   = sizeof(struct EasyStruct);
  requester.es_Flags        = 0;
  requester.es_Title        = "Example requester";
  requester.es_GadgetFormat = "Exit";
  requester.es_TextFormat   = "This is a try!";
  IIntuition->EasyRequestArgs(NULL, &requester, NULL, NULL);
  
  
  IExec->DropInterface((struct Interface *)IIntuition);

  if (IntuitionBase)
    IExec->CloseLibrary((struct Library *)IntuitionBase);
    
  return 0;
}
/*****************************************************************************/
```

First of all, it's good to notice how the name of Base structure is not
referring to a given library anymore, except for rare cases (see the relating
documentation). As for exec.library, even the IExec interface for this
library is already open and available to the programmer. Every function is now
invocable only explicitly by a direct access to the relating interface, such as
IIntuition->EasyRequestArgs(). This makes it difficult to keep compatibility with
other Amiga flavors, so you can use two preprocessor's symbols \_\_USE\_\_INLINE\_\_
and \_\_USE_BASETYPE\_\_, which allows us to keep the AmigaOS3.x function syntax and
to use specific names for libraries' Bases. Our example, rewritten in a
portable manner becomes:

```c
/*****************************************************************************/
#ifdef __amigaos4__
#define __USE_INLINE__
#define __USE_BASETYPE__
#endif
#include <proto/exec.h>
#include <proto/intuition.h>

struct IntuitionBase *IntuitionBase;
struct IntuitionIFace *IIntuition;

int main(void)
{
  IntuitionBase= (struct IntuitionBase *) OpenLibrary("intuition.library",39);

  if (!IntuitionBase)
    return 0;
  
  #ifdef __amigaos4__
  IIntuition = (struct IntuitionIFace *) GetInterface(IntuitionBase,  
                            "main", 1, NULL);
  
  if (!IIntuition)
  {
    CloseLibrary((struct Library *)IntuitionBase);
    return 0; 
  } 
  #endif      
  
  
  struct EasyStruct requester;
  
  requester.es_StructSize   = sizeof(struct EasyStruct);
  requester.es_Flags        = 0;
  requester.es_Title        = "Example requester";
  requester.es_GadgetFormat = "Exit";
  requester.es_TextFormat   = "This is a try!";
  EasyRequestArgs(NULL, &requester, NULL, NULL);
  
  
  #ifdef __amigaos4__
  DropInterface((struct Interface *)IIntuition);
  #endif
  
  if (IntuitionBase)
    CloseLibrary((struct Library *)IntuitionBase);
    
  return 0;
}
/*****************************************************************************/
```

As you can see, we also used the conditional compilation directives, so if the
source is not being compiled on AmigaOS4, calls to GetInterface() and
DropInterface() would be ignored by the compiler.
The symbols for the four amiga systems, of our example use the conditional
code #id defined() are:

	AmigaOS3.x :  #if defined (__AMIGA__) && !defined (__PPC__)
	AmigaOS4   :  #if defined (__amigaos4__)
	MorphOS    :  #if defined (__MORPHOS__)
	AROS       :  #if defined (__AROS__)

To be honest, we could omit the following conditional code:

```c
#ifdef __amigaos4__
#define __USE_INLINE__
#define __USE_BASETYPE__
#endif
```

In this case we should use \_\_USE_INLINE\_\_ and \_\_USE_BASETYPE\_\_ symbols using
the -D option of GCC, in other terms:

gcc mySource.c -o myExecutable -D\_\_USE_INLINE_ -D\_\_USE_BASETYPE_


## 3.4 Differences between various Amiga OS types

As you surely know, the established range of values to represent integer and
decimal variables changes depending on the architecture an operating system is
running on. Since its first version, AmigaOS defines also other types to
declare variables, which reside in the header file exec/types.h.
It's important to notice that such types are dependent from the architecture in
which AmigaOS has born, in other words the Motorola 68000 processor, which is
a 16/32bit CPU.
With the version 4 of AmigaOS and the migration to the PowerPC architecture,
more support types were introduced, the same applies to AROS, which, as you know,
runs on numerous different architectures. AmigaOS3.x types were maintained for
compatibility on both systems, but the relating documentation encourages us to use
new types for the future software to be developed.

We must consider that AmigaOS uses a particular type, APTR, if we know that the
return value of a function is a generic pointer. Anyway in many cases we do not
have such a certainty, so, in similar cases, it's common to use ULONG as
return value, which represents a 32 bit unsigned integer. This trick works
pretty well for 32 bit architectures, while it's totally incompatible with
64 bit and later ones. The reason is pretty trivial: in the case of pointers
larger than 32bit there would be a truncation and thus invalid addresses. 
In the case of AmigaOS4 and MorphOS for modern architectures there isn't such
a problem, because both systems still use 32 bit addresses. In the AmigaOS4 case
it's recommended to use a new type, uint32, to avoid any ambiguity regarding the
size of the type which is being used.
Regarding AROS, the truncation problem is a real situation and easily occurs if
you're writing an AROS x86_64 compatible program. For this reason, AROS
introduces another new type, IPTR, which is the only portable way to represent
a variable that can keep both an integer value as a pointer of any size.

Even MorphOS supports IPTR type.

In the case of portable applications from one Amiga flavor to another, it's good
to employ a similar conditional code:

```c
#if !defined(__AROS__) || !defined(__MORPHOS__)
    #ifdef __amigaos4__
    #define IPTR uint32
    #else
    #define IPTR ULONG
    #endif 
#endif
```

and using IPTR through it.


## 3.5 AROS, variable passing

Some AmigaOS functions often requires variable parameters passing, using
program stack for their manipulations. As we said, AmigaOS assigns a range
of types that ranges from 8bit integers to 64bit integers in modern flavors.
Anyway, some modern CPUs don't allow such handling with all variable types.
For example, some CPUs allow us to handle only some kind of variable on the
stack, other types are accepted only through CPU registers, other CPUs allow
variable passing through registers only and so on.
To solve such issues, AROS uses a particular symbol, STACKED, which must be
put before variable declarations and structures fields to be passed to
Amiga functions (such as BOOPSI messages that will be explained later).
For portable software, it's good to use such conditional code:

```c
#ifndef __AROS__
#define STACKED
#endif          
```

In order to use STACKED without interference with AmigaOS3.x, AmigaOS4 
and MorphOS.

For completeness, it's important to specify the STACK symbol too. In many
AROS declarations you can find such expressions:

```c
STACKULONG foo;

STACKIPTR pointer;
```

These expressions, although they have the same goal of STACKED, they are not
a synonym, in fact:

```c
STACKULONG foo;
```

and

```c
STACKED ULONG bar;
```

Doesn't declare same size variables on AROS, it depends on which
architecture we are running this Amiga flavor on. For example, on AROS
x86-64 STACKULONG declares a 64bit integer, while STACKED ULONG
is a a 32bit integer.

STACK symbol is even supported by MorphOS.


## 3.6 Programs, tasks and processes

We often read that a process is a running program, on Amiga it's better
to make some distinctions. A running Amiga program is called a "Task".
A task is able to invoke almost all the functions that the Amiga
operating system provides, except some, including those offered by AmigaDOS.
The only way to execute such functions unavailable to a simple task is
to invoke them through a process. A process on Amiga is a special Task,
able to use all functions that the operating system provides. The difference
between Tasks and Processes must be searched in the AmigaOS history, and we
are not going to go deeper in this subject here, we only have to know that when
we launch our program, usually it will be a process. Essentially a process
on AmigaOS is a task enriched with other information that allows it to
also use other resources, among which are some system functions. A task and a
process are identified by pointers to structures: the Task structure
and the Process structure. What concerns us here is knowing that a process
(struct Process) contains within it:

- a reference to a task used by Exec to identify it (struct Task pr_Task);

- a reference to a message port (struct MsgPort  pr_MsgPort) see chapter 5.2
