# Interaction between programs and users on Amiga: GUI

*"Neither PC, nor Mac, nor Amiga have invented the concept of mouse-driven
GUI, but in 1985 Amiga offered certainly its most interesting and complete
implementation."*
Massimo Tantignone, "VisualPrefs and the Amiga GUI: tips and tricks", ??/01/2000 

*"Design beautiful Gadgets, Menus, Requesters. Think simplicity and elegance. 
Always remember the fourth grader, the sophisticated user, and the poor 
soul who is terrified of breaking the machine."*
Robert J. Mical, Amiga Intuition Reference Manual

*"In my opinion, neither a programmer nor the operating system shall 
define how GUI elements shall look. The only person who knows the best 
choice is the user of an application.
That's what MUI tries to accomplish. The user of a MUI application
can decide if he wants to have standard system scrollers or absolutely
fancy designed knobs sliding on a stony background pattern."*
Stefan Stuntz, comp.sys.amiga.programmer, 13/08/1993

*"[...]If you had read the MUI docs more carefully, you would have noticed that 
all MUI classes are subclasses of rootclass (since every BOOPSI object 
is a subclass of rootclass)[...]" 
"[...]Commodore implemented a gadget class and an image class (with several
sub classes) and instances of these (and only these) classes are
sometimes called by input.device.[...]"
"[...]MUI classes are not called by input.device and do not affect 
system performance![...]"*
Stefan Stuntz, comp.sys.amiga.programmer, 04/09/1993   

*"From a programmers point of view alone, MUI is heaven. Everything is so 
much easier than using gadtools. MUI isn't slow, either."*
Hans-Joerg Frieden, comp.sys.amiga.programmer, 02/04/1994

*"I like MUI for its configurability and ease of programming, and hence I use it.
[...]GadTools gadgets suck. The can't resize without being removed first, and
that something I don't like. Also, you have to control the keyboard, too,
which is in my opinion a waste. Additionally, most people use GadTools with
a hardcoded font and position, because gadtools (and even BOOPSI without a
layout engine) encourages fixed coordinates. There is no way to use the font-size
directly to position your gadgets.[...]
I do not like the MAGIC prefix, either. But then, I don't judge a program
by its name, or else I would consider the BOOPSI concept a VERY bad one."*
Hans-Joerg Frieden, comp.sys.amiga.programmer, 11/04/1994

*"[...]Its imperative for it (MUI) to be as flexible and as extendable as
 possible."*
Stephan Stunz, comp.sys.amiga.programmer, 14/04/1994  

## 4.1 Tools to build a graphical interface (GUI) on Amiga

A modern user application offers its features through the use of a
graphical interface. Nowadays, a "high level" programmer (he who develops
programs without accessing low level resources) should only use features
offered by BOOPSI, and use GadTools and Intuition functions only if there
is no viable high-level alternative, ready-made BOOPSI classes, that is.
Using GadTools functions or other similar primitives entails a waste of
energy to write the code, and the final result in many cases may not be
consistent with the rest of the Amiga GUI. In order to use BOOPSI, some
concepts about object-oriented programming (OOP from now on) must be clear.

### 4.1.1 OOP primer

This paragraph is addressed to those being not confortable with OOP; those
already familiar with concepts such as instance, object and inheritance, can skip
this paragraph.

OOP is based on concepts like classes and objects, which are very close to the way
of thinking in human beings.

Consider for example how living beings are classified. For example we have animals,
mammals, cats. Let's consider a cat like Sylvester, your neighbour's cat. Sylvester
is a specific example of cat, but if we want to refer to cats in general, we shall
refer to a generic family of animals, a "class" of animals.
A class is a generic entity which holds together common properties; in case of a cat
"class" we know that cats have "properties" such as age, the fur color and so on.

An object is a unique representation of a specific entity: in our case we know that
Sylvester is a black cat of one year old. In other terms, Sylvester is an "object".
We can identify inside a class structural and behavioural characteristics; in the
former case we refer to them with the "attributes" term, while in the latter we talk
about "methods". The attributes of a cat are its colour, age, etc, while the methods
in a cat should be its possible actions, such as running, meowing and eating.

A class can be seen as the matrix from which a particular thing is generated: the
object. The process of generation of an object is called "instantiation", therefore
an object is an instance of a class with all its attributes and methods.

There are generic classes, such as mammals, and more specific classes, such as
the cat. Generally speaking, classes are developed following a hierarchy starting
from a very generic class to a more specific one, through a sort of relationship
that involves a definite group of classes. In our example we could say that the
"cat" class is daughter of the "mammal" class. The "mammal" class is derived from
the "animal" class.

The relationships between different classes are described by a special characteristic:
a child class is provided with the characteristics of the mother class, and possibly
adding also new ones. This mechanism is called hierarchy. In our case, for example,
mammals have breasts and eat, characteristics inherited from mammals, but they also have
whiskers, claws and they meow.

In OOP, each class has two special methods, called constructor and destructor. The
constructor is usually the method that initializes an object instantiated from a class,
while the destructor releases the memory the object was using.

There are also the so called setter and getter functions, used to read and write each class'
object attribute values. Using getter and setter functions allows the object-oriented philosophy
to implement the encapsulation. This concept means that the internal class modules are
protected and handled through a method in charge of checking if data provided is correct.
For example, if a "cat" class has a "colour" attribute, you cannot simply assign a value to
this attribute, one will rather use a "setColour" method; this method will also check whether
by mistake a value "sunny" is being assigned to the "colour" attribute.

Obviously, getter and setter methods would be used to their maximum extend if there was a system
to hide the attributes of a class from the outside. To this purpose, OOP philosophy offers the 
chance to define such attributes as "private", i.e. not directly accessible from the outside. 
Obviously, there are also "public" attributes that accessible from outside the class. Again,
private attributes are not inherited by child classes.

During the process of inheritance, where daughter classes inherit methods from the upper
classes, you can have problems of inconsistency. For example we may consider the class of
"birds" with a daughter class "penguins"; this class, respecting the rules of hierarchy,
will have a "fly" method. But we know that penguins can't fly! This is a typical example of 
inconsistency in the process of inheritance.

To solve this and other problems it's possible to redefine the behavior of a method that the
child class has inherited from the mother class, this process is called method "overriding".
In the above mentioned example, the "fly" method called from a penguin object may have been
reimplemented in the penguin class such as to behave as if it were called a method for swimming.
Not all methods of a superclass must be inherited by the subclass; there are private methods which 
can be used only by instances of the class they belong to.

Other classes can be defined inside a class too, either public or private; in the latter case we 
will have the same behavior described for private attributes.

Finally, all these objects can communicate with each other by exchanging messages.
A message in this case is the combination of a method to be invoked and a value of the attributes 
that this method should manipulate.
Example of a message for an object of the class "dog": method "bark", the value "woof, woof".

##4.2 BOOPSI and MUI: some history

BOOPSI, Basic Object Oriented Programming System for Intuition, sets the basis for OOP on AmigaOS. 
The BOOPSI system is developed following a class hierarchy, which are related to a mother class:
the rootclass. Since its birth, BOOPSI has had a little number of classes which were a bit
extended with AmigaOS 3.0 (1992). Until then BOOPSI didn't have policies about the layout of 
graphical objects nor had many classes to offer; also, some concepts about the interaction between 
classes and font handling were quite laborious, and even the look these classes produced was not top notch.

While the small number of classes and the lack of policies for the positioning of the elements in 
a window allowed great freedom to the management of the graphics application, not everyone was 
willing to support such an effort for the creation of a graphical interface.
For these reasons, again in 1992, a new solution composed of classes was developed, starting right
from the rootclass. This solution solved a lot of problems we mentioned, adopting different
solutions than those proposed by the few BOOPSI official classes.

Such new classes were released with the name of "Magic User Interface": MUI was born.
During the years, through the long wait for a new version of the operating system, many 
programmers used MUI as an API to develop their GUI applications, allowing the system to become 
increasingly robust, comprehensive and versatile.
In 1995 ClassAct was introduced. It was a new set of "pure" BOOPSI classes, extending the original 
BOOPSI system following the philosophies of AmigaOS classes. However MUI had already gained 
the favours of the developers, and the number of applications written using ClassAct never 
exceeded those developed with MUI.
This situation considerably slowed down the development of new ClassAct classes and the debugging 
of the classes of this distribution, while at the same time new third party MUI classes were born,
offering many modern features to programmers and the MUI "core" classes also became increasingly 
robust with the release of new versions of the distribution.

In 1999, a new AmigaOS version (3.5) was finally distributed. It officially incorporated a new 
ClassAct version, called Reaction. However, even this attempt to drive developers towards a more 
"pure" BOOPSI didn't result in programmers abandon MUI. In 2001, with the release of AmigaOS 3.9 
which included new Reaction classes, MUI was choosen by MorphOS as its official API for graphical 
interfaces.
In 2002 MUI was reimplemented by AROS, and renamed Zune. In 2004, the pre-release version of 
AmigaOS 4 was released. This operating system sports both the new Reaction classes and an OEM 
distribution of MUI, providing the programmers with both solutions. In the end, although 
Reaction classes have been greatly improved and developed in recent times, they are not available
on AROS and MorphOS and have many missing features and bugs on AmigaOS3.x. They also have not
the same functionality and robustness of the corresponding MUI classes, and the
number of classes available to Reaction programmers is lower than those available to MUI ones.
That is why the choice for an Amiga programmer without specific needs is obliged: MUI must be used.

## 4.3 BOOPSI programming

In the previous paragraph we mentioned that all BOOPSI classes are related to a single mother 
class called rootclass. The rootclass defines a set of methods, some of them have to be 
implemented in the child classes. BOOPSI methods are classified by an identifier, called MethodID. 
The "pure" BOOPSI methods that we will discuss are declared in \<intuition/classusr.h>:

- OM_NEW: constructor;
- OM_DISPOSE: destructor;
- OM_SET: setter method;
- OM_GET: getter method;

Each MethodID has a prefix, "OM" for these four mentioned methods, which stands for
"ObjectMethod". As we know, the object-oriented philosophy requires that
interaction with an object is made through messages.
A BOOPSI message, called "Object Packet", is made of the MethodID of the method to
be invoked and the parameters it accepts. For example, the object packet of the
OM_NEW and OM_SET methods is the following structure (defined in \<intuition/classusr.h>):

```c
struct opSet{

  STACKED ULONG MethodID;
  
  STACKED struct TagItem *ops_AttrList;
  
  STACKED struct GadgetInfo *ops_GInfo; 
}
```

The first member of the structure is the MethodID, the second member is a pointer to
a list of attributes and corresponding values to be assigned, while for the last
member, currently not useful for our guide, let's just say that it must be set to
NULL in our examples.

We mentioned the second element of the opSet message is a pointer to a list,
but what is this TagItem structure? A TagItem, or more shortly tag, is a [key,value]
structure defined in \<utility/tagitem.h> like this:

```c
struct TagItem {
  STACKED ULONG ti_Tag;  /* Tag identifier, in other words the name     */ 
                         /* of the object's attribute;          		*/
           
  STACKIPTR ti_Data;     /* The value to assign the tag; it's the value */
						 /* to assign to the object's attribute; 		*/
}
```

It's very common, however, handling more tags at a time and for this reason they are saved
in an array (called "tag list") before the message is being dispatched.

In practice, an application sends a message to an object using the AmigaOS 
function called DoMethodA(), or its variation DoMethod().

Such functions are declared in \<clib/intuition_protos.h> on OS4, and are called
IDoMethodA() and IDoMethod(), while in all other Amiga OS variants the declaration
is in \<clib/alib_protos.h>. On OS4, however, these functions can be called using the
"old" name without the "I" prefix.

If, for example, we want to modify an object attribute, we should write:

```c
struct TagItem taglist[] = {{Attribute_ID, Attribute_Value},{TAG_END,0}};
struct opSet msg = {OM_SET, taglist, NULL};
DoMethodA (object, (Msg)&msg);
```

In the first line we create a tagList made by two tags, the first is the
attribute we want to modify, the second tag is a control attribute closing
the taglist declaration. In this case we can use both TAG_END or TAG_DONE.

In the second line we build the actual BOOPSI message, made of the MethodID ("OM_SET"), the 
attribute/value list to be assigned ("taglist") and - last - the third member of the opSet structure that, as we said, must be set to NULL in our case.

In the third line we are simply sending the message to our object. There is a shorter method to do 
this, using the DoMethodA() variation called DoMethod():

```c
struct TagItem taglist[] = {{Attribute_ID, Attribute_Value},{TAG_END,0}};
DoMethod(object, OM_SET, taglist, NULL);
```

This whole procedure is quite laborious and its use is not recommended in practice. There are 
actually some Intuition's functions ready-made to invoke these BOOPSI methods, which take of
performing the right initializations. Such methods are:

- NewObject()     : calls OM_NEW;
- DisposeObject() : calls OM_DISPOSE;
- SetAttrs()      : calls OM_SET;
- GetAttrs()      : calls OM_GET;

Let's modify the last example:

```c
struct TagItem taglist[] = {{Attribute_ID, Attribute_Value},{TAG_END,0}};
DoMethod(object, OM_SET, taglist, NULL);
```

which becomes:

```c
SetAttrs(object, Attribute_ID, Attribute_Value, TAG_END);
```

Invoking such functions requires passing the tag in the argument list of the function itself, and 
this passing mode is called "varargs": a function is variadic when accepts a variable number of 
arguments.

Handling a variable number of parameters in C language has precise rules,
(http://publications.gbdirect.co.uk/c_book/chapter9/stdarg.html) which affect the API of all the 
incarnation of AmigaOS, so we'll talk in more detail this topic later (The relevant SDI include 
file is SDI_stdarg.h) 

Not all methods explained at the start of this paragraph can be applied to every attribute of an 
object: some attributes are not configurable, not readable or not initializable. To indicate the 
applicability of a method on an attribute some flags are included in the documentation of a BOOPSI 
class:

- I: If present, the attribute can be handled by OM_NEW;
- S: If present, the attribute can be handled by OM_SET;
- G: If present, the attribute can be handled by OM_GET;

There are other flags that we've not considered, which refer to methods that we still have not 
examinated.

### 4.3.1 Instantiating a BOOPSI class

As you surely have guessed from the previous paragraph, we must use the Intuition function 
NewObject() to instantiate a BOOPSI class; its declaration is the following:

```c
APTR NewObject(struct IClass *privateclass, 
           UBYTE *publicclassID, 
           unsigned long tag1, ...);
```          

The first two parameters could be confusing to those who have never used Amiga, so it's time to 
introduce private and public BOOPSI classes.
A private class in BOOPSI is a class without a name (a simple ASCII value). A private class is 
*mostly* created by the user to be only employed in his application, while a public class is 
associated with an ASCII name and so it can also be accessed by other applications beyond the one 
that contains the declaration and implementation.

Let's return to the NewObject() function, if we pass NULL as first
parameter, the function will know that it must create an instance of a
public class; and this is the reason why it will ask the name of this class as
an ASCII value in the second parameter. Viceversa, if we want to instantiate
a private class, we have to pass a pointer to the private class to instantiate
as first parameter in NewObject(), but we will deal with this case later.

NewObject() is a variadic function, in fact the second parameter
accepts a tag list, which is built "on the fly" on the stack, following
the varargs functions rules. The NewObject() function returns a pointer to
the instantiated object, or NULL if something went wrong. So, if we have a
class whose ASCII name is "WindowPUB", with a "Title" attribute whose type is
STRPTR (pointer to string), we will have something like this:

```c
Object *objWin; /* Declare a window object */
objWin = (Object *) NewObject(NULL, "WindowPUB", 
                   Title, "This is a Window", 
                  TAG_DONE);
```                  

We will later include the following call to release the memory used by this BOOPSI object:

```c
DisposeObject(objWin);
```
 
The original BOOPSI project stated that for every call to the constructor
of a class there is sooner or later a call to the destructor
of the same class. However, with the new classes, manual calls to every
class destructor are very rare: if a class allows to connect other objects
to its instance (see the following chapter), the calling to the
DisposeObject() function of that class instance will recall the destructor
for every object connected to that instance. In other words, we will have
a cascade deallocation.


### 4.3.2 BOOPSI: adding an object to another object

In the previous chapter we mentioned how some BOOPSI object allow to
be connected to other objects. It's probably better to talk about objects
contained by other objects. The "containment" is another type of hierarchical
relationship in the latest BOOPSI releases, where the contained object becomes,
in some manner, "child" of its container. If, for example, we want a window
with buttons inside, we simply have to instantiate a window object, the
button objects and add these to the newly instantiated window object. So, the
button objects are somehow childs of the window object.
This is, in other terms, more a logical relationship than a physical one. The handling
of the containment in BOOPSI is committed to two methods of the rootclass:

- OM_ADDMEMBER: add an object to another object;
- OM_REMMEMBER: removes a specific object from another object;

For example, if we want to add a button object objBut (public class "ButtonPUB"
with a "Label" attribute) to the window object objWin we will do the following:

```c
Object *objBut; /* we declare a button object  */
objBut = (Object *) NewObject(NULL, "ButtonPUB", 
                Label, "Click me!", 
                  TAG_DONE);

DoMethod(objWin, OM_ADDMEMBER, objBut); 
```

Otherwise, if we want to remove that button from the window:

```c
DoMethod(objWin, OM_REMMEMBER, objBut); 
```

In this last case, we have to be careful when releasing the resources, because
after disconnecting an object from another we obviously must call explicitly
DiposeObject() on the disconnected child object, otherwise the memory will not
be released:

```c
DisposeObject(objBut);
```


## 4.4 From BOOPSI to MUI 

Adding objects to other objects would be an useless feature if such objects
don't supply functions to the user. A user is not willing to press a button
without obtaining a feedback. Following the OOP programming, an object
could interact with another one by exchanging messages or, in other
conditions, the handling of an object by a user could lead to the execution
of one or more methods. In all these cases we talk about "event notification".

The handling of notifications on "pure" BOOPSI is quite peculiar as it involves two
methods from the rootclass called OM_UPDATE e OM_MODIFY; we must instantiate two
child classes of the rootclass called icclass and modelclass and, at the end, we 
must use the ICA_TARGET and ICA_MAP attributes of these two classes. Moreover,
there are other implementation details to follow that make this work a bit
laborious. Moreover, if we want to program following the standard OOP, therefore
developing with subclasses, "pure" BOOPSI forces to a number of arrangements
to follow that lead the programmers' efforts towards the graphical interface instead
of the application itself.
Another important aspect to keep in mind using "pure" BOOPSI programming is the
difficulties to implement GUIs that follows a Multiple Document Interface philosophy
(MDI), which is based on repeatedly adding and removing graphical objects on the fly.
This lack of "pure" BOOPSI programming will force you to implementation of GUIs based
on multiple windows, a philosophy very widespread in the middle of the '90.
Another problem not easily solvable with "pure" BOOPSI programming is object 
management focus, more precisely when many graphical objects want to control 
shortcuts from keyboard in the same GUI. The standard behaviour of "pure" BOOPSI assigns 
all inputs to the focused object, so if for example a string object doesn't support 
that kind of keyboard shortcut, the input will not be managed.
In other words "pure" BOOPSI lacks input inheritance between objects. "Pure" BOOPSI
programming lacks also drag&drop support between graphical objects of a GUI,
so you can't implement a GUI where a user can drag&drop UI components at his
own will into windows of your program (like it happens inside the Firefox UI). Sure, you
can write from scratch this kind of thing into your "pure" BOOPSI application,
but it's not easy and it takes too much time...
Luckily the Amiga universe offers a solution to all these problems: the most loved
and hated Amiga Users' GUI, in other words: MUI.

### 4.4.1 MUI: overview

As already mentioned, MUI is a collection of classes, linked one another following a complex 
hierarchy that starts from the Notify and Semaphores classes, both children of the rootclass. For 
the moment we will focus only on the Notify class and all of its subclasses. The Notify class 
implements a new mechanism to notify events, which is inherited by all its subclasses, 
following OOP rules. The class hierarchy is shown in the following simple graph:

	 rootclass                    
	 +--Notify                  
	 !  +--Family                
	 !  !  *
	 !  !      
	 !  +--Application
	 !  !           
	 !  +--Window               
	 !  !  * 
	 !  !        
	 !  +--Area                 
	 !  !  +--Group
	 !  !  *  *

Family is a generic class whose instances are able to keep objects
containing other objects. In other words, an instance of Family could
contain some Menu objects, that could contain other menu items or
other menus as well.
Application is a class whose instance represents an application that
runs on the system, which can have a variable number of windows (Window
class instances).

Finally, the Area class is the mother of all other MUI gadgets and handles
all their informations, such as their size, their look and their
position. The Area class handles user inputs too. It's important to notice
that Area doesn't set the position of the elements inside one of its instances,
because Area is a generic class which can be used to build more complex gadgets.
Layout handling is performed by a child class of Area, called Group.
In theory, all these classes should have a direct relationship; in other
words, Area should be child of Window, which should be child of Application
which should be child of Family. The author of MUI says that a direct
relationship between these classes wasn't possible to implement, due to some
BOOPSI limits.
Nonetheless, an instance of Application can contain one or more instances of Window,
and this is valid also for Family-->Application and for Window-->Area, partially solving the non-physical relationship problem.

Each MUI class is identified by a name preceded by "MUIC_" prefix, a class
attribute is identified by the "MUIA_" prefix, a method is identified by
the "MUIM_" prefix and so on... All the BOOPSI rules we talked about regarding
the methods of the rootclass are valid on MUI too, even if this set of API
provides the programmer with an alternative way for object instantiation
and destruction. It's possibile to use MUImaster.library's MUI_NewObject()
and MUI_DisposeObject() methods instead of NewObject() and DisposeObject().
We'll compare their use creating an instance of the MUIC_Window class:

```c
objWin = (Object *) NewObject(MUI_GetClass(MUIC_Window), NULL, 
                                  MUIA_Window_Title, "This is a Window", 
                              TAG_DONE);
```                              

becomes:            

```c
objWin = (Object *) MUI_NewObject(MUIC_Window, 
                                      MUIA_Window_Title, "This is a window", 
                                  TAG_DONE); 
```                                  
            
First of all, we notice that in the first case any MUI class is seen
as a BOOPSI private class. The instantiation occurs after getting the
pointer to the MUI class using the MUI_GetClass() method. Such procedure can
be problematic sometimes, as MUI_GetClass() keeps open the class we are
getting the pointer from, until the FreeClass() function is called; so, forgetting
to invoke FreeClass() could generate errors in the code. MUI_NewObject() solves
the problems of MUI class opening and closing because a single call to
DisposeObject() or MUI_DisposeObject() will leave the system clear.
Again, if MUI_NewObject() will not be able to instantiate an object
containing more objects previously instanced, it will deallocate these
objects that should have been part of the new object (not created).


### 4.4.2 MUI: An example of a simple graphical interface

Let's try building a simple graphical interface with MUI, we want to get
a window with a string as first element, and a button beneath it as second
element. Using MUI classes we will have the following snippet of code for
the button:

```c
Object *button = MUI_MakeObject(MUIO_Button, "Click me!");
```

As you can see, we don't instantiate an object from a class, but we
get an object from a so called "prebuilt object". We talked about how
the Area class handle user input, this class can react to some input
in a variety of ways, such as reacting like it was a button, or something
totally different. This is why MUI doesn't have a generic button class;
in fact on MUI a button is an instance of the MUIC_Text class with a border
as attribute and a behaviour assigned to react to the release of a mouse or
keyboard button. This way, it's very simple to create more complex
gadgets, but it's a bit awkward building a simple button.
For this reason, MUI provides pre built objects, ready for use. These objects
are identified by the "MUIO_" prefix. The MUI_MakeObject() function takes a
prebuilt object as first parameter plus its optional parameters that aren't a tag
list (therefore there isn't TAG_END or TAG_DONE as last parameter). This is how we
instantiate a String from the MUIC_String class:

```c
Object *string = MUI_NewObject(MUIC_String, 
									MUIA_Frame, MUIV_Frame_String, 
                                    MUIA_String_Contents, (IPTR) "Click on the button...", 
                                TAG_DONE);
```                                

Please notice the MUIA_Frame attribute that allows to define the border in which our string
will be put.

As we mentioned, in order to delegate MUI to arrange the gadgets layout we must use the MUIC_Group
class:
          
```c
Object *group = MUI_NewObject(MUIC_Group,
                                   MUIA_Group_Child, string,
                                   MUIA_Group_Child, button,
                               TAG_DONE);
```

The default layout of the objects linked to an instance of MUIC_Group is to align them
in the same column, in which the first inserted element will be the first element
at the top of the column. To change the layout we must work on the attributes
provided by the MUIC_Group class. We recommend reading the relevant documentation.

At the end, we can instantiate our window:

```c
Object *window = MUI_NewObject(MUIC_Window,
                                     MUIA_Window_Title, "My Window",
                                     MUIA_Window_ID ,MAKE_ID('M','a','i','n'),
                                     MUIA_Window_RootObject, group,
                                 TAG_DONE);
```                      

In this last instantiation process we can notice the MUIA_Window_ID attribute,
which allows the system to identify the window with an ID (using the MAKE_ID()
macro our characters will be condensed in an ULONG. This macro is in
\<libraries/iffparse.h>). This attribute is important if the user wish to save,
for example, the size of the program window. Everything will be transparent to
the programmer.
We must pay attention to the MUIA_Window_RootObject attribute. It establishes what
the windows is going to contain (in other words, its children); usually it contains a group,
if you need to display multiple gadgets. A MUIC_Window object can have only one
child.

As we previoulsy said, we must assign a MUIC_Application object to our window:

```c
Object *app = MUI_NewObject(MUIC_Application,
                                MUIA_Application_Title  , "ShInKy Tutorial GUI",
                                MUIA_Application_Base  , "ShInKyTutorialGUI",
                                MUIA_Application_Description, "MUI GUI Example",
                                MUIA_Application_Window, window,
                            TAG_DONE);
```                            

MUIA_Application_Title is used by the system as the application name which will
be displayed to the user, while MUIA_Application_Base is the name used by
the system to identify the application. MUIA_Application_Description is our
application's description the system will provide to the user.
Now you can make the window visible (in other words, open it) setting the
MUIA_Window_Open attribute to TRUE, like this:

```c
SetAttrs(window, MUIA_Window_Open, TRUE, TAG_DONE);
```

We should mention that a MUIC_Window object exists only in the context of a
MUIC_Application object, this means that you cannot make your window visible
until you add it to your application object, otherwise you will get a crash.

We started building the graphical interface from the innermost to the outermost
element, avoiding passing a NULL pointer to the above mentioned MUIA_Group_Child,
MUIA_Window_RootObject and MUIA_Application_Window attributes. It's time to go
back to the rootclass' OM_ADDMEMBER method we have previously described (4.3.2),
which allows us to build our interface as follows:

```c
Object *app = MUI_NewObject(MUIC_Application,
                                MUIA_Application_Title  , "ShInKyButton",
                                MUIA_Application_Base  , "ShInKyButton",
                            TAG_DONE);

Object *group = MUI_NewObject(MUIC_Group, TAG_DONE);


Object *string = MUI_NewObject(MUIC_String, 
                                    MUIA_Frame, MUIV_Frame_String,
                                    MUIA_String_Contents,(IPTR) "Click the button...",
                                TAG_DONE);
        
Object *button= MUI_MakeObject(MUIO_Button, "Click me!");

DoMethod(group, OM_ADDMEMBER, string);
DoMethod(group, OM_ADDMEMBER, button);

Object *window = MUI_NewObject(MUIC_Window,
                                     MUIA_Window_Title, "My Window",
                                     MUIA_Window_ID ,MAKE_ID('M','a','i','n'),
                                     MUIA_Window_RootObject, group,
                                 TAG_DONE);


DoMethod(app, OM_ADDMEMBER, window);
```

Using this method we can add children objects to other objects after their instantiation.
If, for example, we want to remove our window from the app object, we will write the following 
steps:

```c
SetAttrs(window, MUIA_Window_Open, FALSE, TAG_DONE); /* close the window;*/

DoMethod(app, OM_REMMEMBER, window); /* remove the window object         */
                                     /* from the application object;     */
```                               

If we want to add MUIC_Group objects to a window we must close it first,
while if we want to add or remove objects from a MUIC_Group instance, we must
explicitly notify these actions to MUI. To do this, we must surround the code
(in which we will perform the removal or addition of elements in the group)
with the MUIM_Group_InitChange method and notifying the end of the changes invoking
the MUIM_Group_ExitChange method:

```c
DoMethod(group, MUIM_Group_InitChange);
.
.
.
/*changes*/
.
.
.
DoMethod(group, MUIM_Group_ExitChange);
```

Feel free to decide about the creation and removal of objects according to your needs.

## 4.5 MUI: Notifications

In 4.4 we talked about the notification concept. A GUI item can react to a user triggered event, 
performing an action that can involve other graphical objects.
Following the example in the previous paragraph, now we want the content of the string and the 
button to react when we click the button. To do so, MUI employs the MUIM_Notify method of the
class with the same name; since almost alla MUI classes are children of MUIC_Notify, all our 
instances can use the MUI notification system.
MUIM_Notify method can be used with three different techniques: an AmigaOS standard called 
"callback hook", a notification through methods inside our private classes, or using notificable 
attributes. For the time being, we will deal with the first technique, we will see the other (more 
OOP compliants) later.

### 4.5.1 MUI: Notifications with callback hook

The philosophy behind the callback hook involves the extension of a module
(a library, a device, a class, etc...) by hooking new functions. To obtain this,
a new function is hooked to a module using a structure called Hook. The Hook
structure is different in the various AmigaOS flavours, so to keep compatibility,
we will use the SDI tools (see Chap 1), specifically a header called SDI_hook.h.
In practice, using SDI_hook.h, we can build the function to hook and its relative hook
in this way:

```c
/*Function to hook*/
HOOKPROTO(NameOfTheFunction, 
          ReturnValue,
          ObjectToHandle,
          ParametersToReceive);
{
....
}
/*Hook to be used*/
MakeHook(HookName, NameOfTheFunction);
```

SDI_hook.h allows us to choose between different ways to create functions
and to create hooks. We suggest reading this header for further details.

Following the example in the previous paragraph, we first write the hookPutVal()
function able to perform the change of the attributes of the button and the string
objects, then the relative Hook called buttonHook:

```c
HOOKPROTONO(hookPutVal, void, APTR *data)
{

  Object *button, *string;
  
  button=(Object *) *data++;
  string=(Object *) *data; 
    
  SetAttrs(string, 
           MUIA_String_Contents,
           (IPTR) "Button clicked!",
           TAG_DONE);
     
  SetAttrs(button, 
           MUIA_Text_Contents,
           (IPTR) "Clicked!",
           TAG_DONE);
     
  SetAttrs(button, 
           MUIA_Disabled,
           TRUE,
           TAG_DONE);  
}
MakeStaticHook(buttonHook,hookPutVal); 
```

As you can see in the function declaration, we are using the "NO" variant
provided by SDI_hook.h that allows us avoiding the parameter
representing the object to be manipulated; actually in this case we are dealing
not only with one object, but two. These objects are passed by address, more
precisely the "data" variable contains the parameters received by the invoked function,
whose first parameter passed with data is the hook address. To obtain
the address of the first object passed to the function after the hook, we
cast to (Object *) the pointer. We proceed incrementing the pointer position to
retrieve the following objects; in this case we only have a button and a string.
Now we got all the data we need to handle MUI objects: we can proceed to the three SetAttrs()
calls, the first of them will set the text "Button clicked!" inside our MUIC_String object, the 
second call changes the text inside the button and the third disables the button.
The hooking of the function to an object is made by the MUIM_CallHook method, through MUIM_Notify:

```c
DoMethod(button,  MUIM_Notify, 
                  MUIA_Pressed, FALSE,
                  MUIV_Notify_Self,
                  4,
                  MUIM_CallHook,
                  &buttonHook,
                  button,
                  string);
```                  

Invoking MUIM_Notify through a DoMethod() function call will bind a notification to an object.
This method takes the following parameters:

- the object that will activate a notification;
- the attribute of the object to be checked in order to activate a notification;
- the object on which the notification method will be executed;
- the number of parameters passed to the notification method;
- the notification method;
- the parameteres, if any;

In our example:

- MUIM_Notify is the method that will be invoked on the button click event;
- MUIA_Pressed is the attribute that will be checked to be FALSE, that means
the notification will be triggered on release of the button after being pressed;
- The notification method must be applied to the button itself (MUIV_Notify_Self);
- The number of parameters for the notification method: 4;
- The notification method: MUIM_CallHook;

To be honest, the number "4" indicates how many parameters will be after
the MUIV_Notify_Self value. Obviously, the programmer must know the number of
parameters that will be passed to the hook function; a wrong number of parameters
specified here could lead to a disaster later inside the hook due to the pointer
arithmetic we previously explained.

The value MUIV_Notify_Self is used to decide whether to trigger the notification method,
in our case MUIM_CallHook. MUIM_Notify takes these decisions using a predeclared value in
the MUI system. Generally, a MUI value is identified by the "MUIV_" prefix, in the MUIV_Notify 
case we can choose from:

- MUIV_Notify_Self: the object itself on which the MUIM_Notify method is called;
- MUIV_Notify_Window: the MUIC_Window instance that contains the object;
- MUIV_Notify_Application: the MUIC_Application instance that contains the object's
  mother window;
- MUIV_Notify_Parent: the object's parent instance;

The MUIM_CallHook method calls a function through the relative hook,
in our case "buttonHook", whose hooked function hookPutVal() receives button
and string as parameters.

### 4.5.2 MUI: window closing and the old notify method with ReturnID

Even the close gadget at the top of the window managing the application exit
is handled by the MUIM_Notify method. Following the example in the previous paragraph,
our window object is handled as follows:

```c
DoMethod(window, MUIM_Notify, 
                   MUIA_Window_CloseRequest, TRUE,
                   MUIV_Notify_Application,
                   2,
                   MUIM_Application_ReturnID,
                   MUIV_Application_ReturnID_Quit);
```                   

We are declaring that when the MUIA_Window_CloseRequester turns to TRUE (the user clicks
the window close gadget), the method MUIM_Application_ReturnID must be triggered on the 
MUIC_Application instance (identified by MUIV_NotifyApplication), passing a
MUIV_Application_ReturnID_Quit value.

MUIM_Application_ReturnID is a method that "forces" the MUIM_Application_(New)Input
method to return a value, in our case the next call to MUIM_Application_Input
will return MUIV_Application_ReturnID_Quit.

MUIM_Application_Input is a method, now deprecated, used to catch all the
return values associated to user inputs on a MUI application. This involved
the use of a big control cycle, in which every return value of a MUI interface
was checked. This technique is the same of the "pure" BOOPSI programming and
assigns the input controlling to the application itself. Even though in some
situations this kind of handling can be avoided, using Reaction classes, on
"pure" BOOPSI a big control cicle is the standard way of handling inputs.
MUI keeps a similar method for backward compatibility with older applications and
only to handle the close gadget of the window. More precisely, 
a faster version of MUIM_ApplicationInput is used for this goal, called
MUIM_Application_NewInput; actually, we will invoke MUIM_Application_ReturnID
with:

```c
IPTR sigs = 0;
while (DoMethod(app, MUIM_Application_NewInput, (IPTR)&sigs) != MUIV_Application_ReturnID_Quit)
{
  ;
}
```

Basically we check that MUIM_Application_NewInput returns a value different in the sigs variable 
from MUIV_Application_ReturnID_Quit. Otherwise the loop will exit, allowing the application to 
follow closing operations. Is a common practice to add a check for the interrupt signal CTRL+C 
inside that loop, in order to catch the CTRL+C signal when the application is launched from the 
command line (the Shell).

```c
while (DoMethod(app, MUIM_Application_NewInput, (IPTR)&sigs) != MUIV_Application_ReturnID_Quit)
{
  if (sigs)
  {
    sigs = Wait(sigs | SIGBREAKF_CTRL_C);
    if (sigs & SIGBREAKF_CTRL_C) break;
  }
}
```

To learn about the Wait() function and the SIGBREAKF_CTRL_C see paragraph 5.1

### 4.5.3 Zune and MUIM_Application_Execute

In the previous paragraph we described a while loop to check for the application
closing signal, usually called the "main loop".
Zune offers the programmer the chance to avoid the loop, leaving the closing task to
a new method, MUIM_Application_Execute. Basically this method hides the use of the main
loop from the programmer, making everything look more readable and modern. Its syntax
is simply:

```c
DoMethod(app, MUIM_Application_Execute);
```

We leave to the reader the implementation of a portable MUIM_Application_Execute method.
Informations useful for such implementation will be explained later.

## 4.6 At the heart of a BOOPSI/MUI class: the Dispatcher

Up until now we just created instances of classes already available, without knowing
how to create our own. Object-Oriented Programming (OOP) serves the purpose of creating
highly modular applications. Following the rules of OOP, developers create also software
modules that can be used again in different contexts, and MUI programming is no exception.

The engine behind a BOOPSI (and MUI) class that makes it an active module is a
peculiar function called dispatcher. When a BOOPSI object receives a message,
the dispatcher checks the message in order to verify if the receiver is able
to handle its parameters (the message itself). In other words every Intuition
and MUI function we've talked about until now use the dispatcher. A BOOPSI
object, in the end, is nothing but a plain C structure and it could not perform
any action without a dispatcher.

Now we know that each BOOPSI class has a parent class; this relationship goes up
until the rootclass. Each class has its own dispatcher function. If the class dispatcher
does not recognize a parameter received, it will push the unknown parameter to the
parent class. This could happen up until the rootclass itself that, in this
case, would return an error message.

In other words, the dispatcher is the function that invokes the class methods it
belongs to, choosing which one is appropriate for that message. The dispatcher could
implement itself the code to manage the message or invoke the corresponding class method.
Also, the declaration and the definition of a dispatcher changes depending on which
Amiga flavour we are working. Luckily the SDI Tools will help us again providing two
macros, again in sdi_hook.h, called DISPATCHERPROTO() and DISPATCHER(). DISPATCHERPROTO()
is the macro used to declare the dispatcher prototype and accepts just one argument, the
name of our dispatcher:

```c
DISPATCHERPROTO(MyDispatcher);
```

With the DISPATCHER() macro we define the real function:

```c
DISPATCHER(MyDispatcher)
{
  switch (msg->MethodID)
  {
    case OM_NEW : return myNew(cl,obj,(APTR)msg);
  }

  return DoSuperMethodA(cl,obj,msg);
}
```

In this example the dispatcher only takes care of managing the OM_NEW method
of its class, invoking a myNew() function that will be described later.
After having managed (if needed) OM_NEW, the dispatcher sends the message to the
rootclass, using the DoSuperMethodA() of Intuition. The parameters "cl", "obj"
and "msg", were received by the dispatcher itself. The prototype of the dispatcher,
on any Amiga-ish incarnation, needs these three parameters. "cl" is the class the
dispatcher belongs to, "obj" is the object that has received the message and "msg"
is the message itself, "opSet" in our example (see paragraph 4.3).

### 4.6.1 Implementation of a MUI private class

OOP's strength lies on the possibility to let the programmer write his/her own classes and
use them again in different contexts. For example, if we would like to subclass MUIC_Group, 
creating a subclass containing the two objects of paragraph 4.5 (the button and the string),
first of all we should declare a private data area (a simple struct) of our new class:

```c
struct myDataArea
{    
   Object *button, *string;
   STRPTR labelButton, labelStr;
};
```

Now, according to BOOPSI rules variables declared inside the data area will be
later recognized as private attributes of the class.

Speaking of methods, a MUI class provides implementation of the following
methods:

	- OM_NEW;
	--- MUIM_Setup;
	--- MUIM_AskMinMax;
	------ MUIM_Show;
	--------- MUIM_Draw;
	------ MUIM_Hide;
	--- MUIM_Cleanup;
	- OM_DISPOSE;

Each method will be implemented only if really needed.  For the moment we will
explain only how to implement the OM_NEW method.

### 4.6.2 Implementing OM_NEW and its external tags

Looking at the sample dispatcher in paragraph 4.5.2, a possible definition of a myNew()
function (which will represent OM_NEW method implementation) could be:

```c
IPTR myNew(struct IClass *cl,Object *obj,struct opSet *msg)
{
  struct myDataArea *data;
  .
  .
  .
  .
  /*call to method OM_NEW of superclass*/
  .
  .
  .

  data = INST_DATA(cl,obj);
  
  .
  .
  .
  .
  /*return pointer to istantiated object*/   
}
```

A function in charge of implementing OM_NEW will always have this signature:
"cl" is the class the dispatcher belongs to, "obj" is the object that has received
the message, "msg" is the message. INST_DATA() is a macro used to get a pointer to
the private data area of the caller object.

The data area of our class is nothing but the struct we declared before and 
the other superclasses' data areas (polymorphism), if any. Allocation of the superclass
data area happens when the OM_NEW method of the superclass is invoked. This process
repeats and goes up until the rootclass.
The OM_NEW method of the rootclass will now allocate enough memory for its own data area,
passing the pointer to the subclass: this is how an instance of the rootclass is created.
The subclass, upon receiving the rootclass object, will use the INST_DATA() macro to tell
the system to allocate more memory to be added to the superclass data area (identified by
the rootclass pointer), and then populate it with its own data area.
After that, and after having executed other actions (if any), the OM_NEW method of
said class will send this data area to the subclass, again using a pointer to the instanced
object.
Each class performs these actions until our OM_NEW method is reached, which - again - will
perform these actions, again through the INST_DATA() macro.

Before invoking the OM_NEW method of the superclass, we may want to read parameters
(a message, that is) - if any are existing - passed to our method.
In our example, if we want to inizialize the values of labelButton and labelStr from our
OM_NEW overload method, we should associate these variables to labels (ID) that our method
will recognize. Here's how to declare such IDs:

```c
#define MUI_CLASS_TUTORIAL (TAG_USER | 0x80420000)
#define MUIA_MUIClassTutorial_TextStr MUI_CLASS_TUTORIAL + 1
#define MUIA_MUIClassTutorial_LabelBut MUI_CLASS_TUTORIAL + 2
```

Here we have defined three symbols, the location of the last two of them depending
on the first.
MUI_CLASS_TUTORIAL is the first defined symbol and his value is given by a
bitwise OR on TAG_USER (a system value used to separate user tags from system
tags) and the hexadecimal value 0x80420000. This hex value is not randomly
choosen: MUI documentation, in fact, recommend using hex values in the range
0x80420000 - 0x80429999 for public attributes of your own classes.

Actually, if we are creating private classes, not reachable by other tasks othen
than our own, we could define these symbols as follows:

```c
#define MUIA_MUIClassTutorial_TextStr  TAG_USER + 20
#define MUIA_MUIClassTutorial_LabelBut TAG_USER + 21#
```

and so on...

Remember to use values not too close to TAG_USER, otherwise in some conditions weird
behaviour could arise.

Now we should analyze the message received, checking whether he user has possibly sent
initialization code for labelButton and labelStr:

```c
Object *string, *button;        /*we alloc objects which later will*/
STRPTR labelStr, labelButton;   /*populate our data area*/

{/*block for tag list reading*/
  struct TagItem *tags, *tag;

  tags=((struct opSet *)msg)->ops_AttrList;
  while (tag=NextTagItem(&tags))
  {
    switch (tag->ti_Tag)
    {
      case MUIA_MUIClassTutorial_TextStr:
      if (tag->ti_Data)
        labelStr= (STRPTR) tag->ti_Data;
      break;
      
      case MUIA_MUIClassTutorial_LabelBut:
      if (tag->ti_Data)
        labelButton= (STRPTR) tag->ti_Data;
      break;
    }
  }
}
```

As we know, the opSet message (see paragraph 4.3) has a variable ops_AttrList pointing
to the passed taglist. This is why we have declared two pointers (tags and tag), they
will be used while iterating through the list using NextTagItem() function from
utility.library.
Each call to NextTagItem() pops the current item from the list into the tag variable.
Using a switch we check the value of tag->ti_Tag of the current item against the
values we have declared before: if tag->ti_Tag equals MUIA_MUIClassTutorial_TextStr,
for example, labelStr will be initialized to the value from tag->ti_Data, while
if tag->ti_Tag equals MUIA_MUIClassTutorial_LabelBut, the value in tag->ti_Data will
be put into labelBtn.

It's important to notice how the declaration of NextTagItem() on AROS is slightly different
than other Amiga-ish operating systtems; for this reason the above mentioned code could
emit warnings when compiled.
In order to solve this issue, we can define our own TAGITEM define:

```c
#ifdef __AROS__
  #define TAGITEM const struct TagItem **
#else
  #define TAGITEM  struct TagItem **
#endif  
```

and use it to cast the value returned:

```c
...
 while (tag=NextTagItem((TAGITEM)&tags))
...
```

It's common practice using such a syntax (NextTagItem() associated with a switch) when
implementing the OM_SET method when there are a lot of attributes to manage. It is
possible to make the code more compact by using the shortcuts GetTagData() from
utility.library:

```c
IPTR GetTagData(Tag,IPTR,struct TagItem *);
```

This function requires the tag to be used as first argument, a default return value
if the label is not found as second argument and the already mentioned ops_AttrList as
last argument.
Replacing the switch with GetTagData() is described below:

```c
struct TagItem *tags;
tags=((struct opSet *)msg)->ops_AttrList;

labelStr = (STRPTR) GetTagData(MUIA_MUIClassTutorial_TextStr, (IPTR)NULL, tags);
      
labelButton = (STRPTR) GetTagData(MUIA_MUIClassTutorial_LabelBut, (IPTR)NULL, tags);      
```

We have mentioned there could be an attribute not managed by the OM_NEW
method we are overloading. Such an attribute must be handled by the superclass'
OM_NEW (which will be invoked anyway, also to solve this kind of issues).

At this stage we should istantiate the label and button objects, just like we did before
(see paragraph 4.4.2) and initialize them with the labelStr and labelButton values.

In order to call the superclass' OM_NEW method we can either use DoSuperMethodA() or
its variadic version DoSuperMethod():

```c
struct TagItem taglist[] = {{MUIA_Group_Child, (IPTR) string},
                            {MUIA_Group_Child,(IPTR) button},
                            {TAG_MORE, (IPTR) msg->ops_AttrList}};

obj =(Object *) DoSuperMethod(cl, 
                              obj,
                              OM_NEW,
                              taglist,
                              NULL);
            
if (obj==NULL)
	return 0;
```

With DoSuperMethod() we invoke the superclass', in our example MUIC_Group, OM_NEW method
passing a tag list that will let the method create a group with our string
and our label as children. TAG_MORE signals the presence of a new taglist which pointer -
as we know - is found in tag->ops_AttrList.
If DoSuperMethod() returns NULL it means the arguments passed were not recognized
by the superclass' method.
This syntax is a bit tedious, so it is common practice using the utility function
DoSuperNew(), which we will better explain later.
Suffice to say for the moment that this function can replace the above code with the
following:

```c
obj = DoSuperNew(cl, 
                 obj,
                 MUIA_Group_Child, string,
                 MUIA_Group_Child, button,
                 TAG_MORE, msg->ops_AttrList);

if (obj==NULL)
  return 0;
```

With DoSuperNew() we passed the objects label and button to our superclass'
OM_NEW method; these objects will become children of the next object we will
instantiate.
These objects will be automatically positioned inside the container object
of MUIC_Group class and, with that, they will represent the instance of our
private MUI class.
Now there's only to invoke INST_DATA(), that will provide our own private data
structure that will be populated as follows:

```c
data = INST_DATA(cl,obj);

data->labelStr    = labelStr;
data->labelButton = labelButton;
data->str         = string;
data->button      = button;

return obj;
```

At this point we have shown all there's to do to implement the OM_NEW method.

### 4.6.3 Using a private class

After having implemented all that is needed in the previous paragraphs,
we are now able to use our new MUI class.
To do so, we use the method MUI_CustomClass() from MUImaster.library.
The syntax is as follows:

```c
struct MUI_CustomClass *mcc;

mcc = (struct MUI_CustomClass *) MUI_CreateCustomClass(NULL,
                                                       MUIC_Group,
                                                       NULL,
                                                       sizeof(struct myDataArea),
                                                       ENTRY(MyDispatcher));
```

The first parameter of this function call is NULL when dealing with private classes;
it is only assigned if we are sharing a public MUI class, that's all we need to know
at the moment.
The second parameter is our class's superclass, from which it will inherit methods
and attributes.
The third parameter is only used if our subclass is daughter of another private class, so
this parameter too is NULL in this case.
The fourth parameter is the size of our private data struct.
The fifth and last parameter is the dispatcher name. The ENTRY() macro, from the SDI
tools, is used by MorphOS to tell a native PPC class from a 68K one; other compilers
will ignore this macro. Using this macro allows us to be compatible with MorphOS.

Now, if the call to MUI_CreateCustomClass() succeded, we should have in "mcc"
the instance of our private MUI class, to be used as a parameter for the Intuition method 
NewObject() as follows:

```c
Object *MyObj; 

MyObj = (Object *) NewObject(mcc->mcc_Class, 
                             NULL,
                             MUIA_MUIClassTutorial_TextStr,(IPTR) "Click the button...",
                             MUIA_MUIClassTutorial_LabelBut,(IPTR) "ClickMe!",
                             TAG_DONE);
```                             

As you can see in the above example, a MUI private class is identified by a MUI_CustomClass
data structure that contains a pointer "mcc_Class" to a IClass struct (used to identify
private BOOPSI classes). The official documentation recommends to not use the MUI_NewObject()
function. With NewObject() - as we explained earlier - we are invoking the OM_NEW method
of our class, and we are passing it the values for the attributes MUIA_MUIClassTutorial_TextStr
and MUIA_MUIClassTutorial_LabelBut.

After having used our class, we must deallocate it from the memory:

```c
MUI_DeleteCustomClass(mcc);
```

this call must be put after the usual MUI_DisposeObject();

So, after inserting MUI_CreateCustomClass() in a special function, our code is now complete:

```c
/****************************************************************************/
//file sys.h
/****************************************************************************/
/* Includes */
#ifndef __SYS_INCLUDES__
#define __SYS_INCLUDES__

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/utility.h>
#include <proto/intuition.h>

#include <proto/MUImaster.h>
#include <libraries/mui.h>

#if !defined (__amigaos4__)
#include <clib/alib_protos.h>
#endif
                
#include <SDI_compiler.h>
#include <SDI_hook.h>
#include <SDI_stdarg.h>


#if !defined(__AROS__) || !defined(__MORPHOS__)
#ifdef __amigaos4__
#define IPTR uint32
#else
#define IPTR ULONG
#endif
#endif

#ifndef __AROS__
#define STACKED
#endif

#ifdef __AROS__
    #define TAGITEM const struct TagItem **
#else
    #define TAGITEM  struct TagItem **
#endif

#if !defined (__MORPHOS__)
Object * VARARGS68K DoSuperNew(struct IClass *cl, Object *obj, ...);
#endif

#endif   
         
/****************************************************************************/

/****************************************************************************/
// file MUIClass.h
/****************************************************************************/

#ifndef __MYMUICLASS__
    #define __MYMUICLASS__

    #define MUI_CLASS_TUTORIAL (TAG_USER | 0x80420000<<16)

    #define MUIA_MUIClassTutorial_TextStr MUI_CLASS_TUTORIAL + 1
    #define MUIA_MUIClassTutorial_LabelBut MUI_CLASS_TUTORIAL + 2

    struct MUI_CustomClass *initMUIClass();
#endif    
/****************************************************************************/

/****************************************************************************/
//file MUIClass.c
/***************************************************************************/

#include "sys.h"
#include "MUIClass.h"

struct MyData
{
    Object *button, *str;
    STRPTR labelButton, labelStr;
};


///hookPutVal
HOOKPROTONO(hookPutVal, void,APTR *data)
{
    Object *bt_1, *str;
        
    bt_1=(Object *) *data++;
    str=(Object *) *data;
                
    SetAttrs(str, MUIA_String_Contents,(IPTR) "Clicked button...", TAG_DONE);
    SetAttrs(bt_1, MUIA_Text_Contents,(IPTR) "Clicked!", TAG_DONE);
    SetAttrs(bt_1, MUIA_Disabled, TRUE, TAG_DONE);    
}
MakeStaticHook(buttonHook, hookPutVal);
///

///OM_NEW()
IPTR mNew(struct IClass *cl, Object *obj, struct opSet *msg)
{
    struct MyData *data;
        
    STRPTR labelStr, labelButton;
    Object *str, *button;
    struct TagItem *tags;

    tags=((struct opSet *)msg)->ops_AttrList;

    labelStr= (STRPTR) GetTagData(MUIA_MUIClassTutorial_TextStr, (IPTR)" ",tags);

    labelButton= (STRPTR) GetTagData(MUIA_MUIClassTutorial_LabelBut, (IPTR)" ",tags);

        
    str = MUI_NewObject(MUIC_String,
                            MUIA_Frame, MUIV_Frame_String,
                            MUIA_String_Contents,(IPTR) labelStr,
                        TAG_DONE);
        
    button= (Object *) MUI_MakeObject(MUIO_Button,(IPTR) labelButton, TAG_DONE);
                                        
    obj = (Object *) DoSuperNew(cl, obj,
                                    MUIA_Group_Child, str,
                                    MUIA_Group_Child, button,
                                TAG_MORE, msg->ops_AttrList);

    if (obj==NULL)
        return 0;

    data = (struct MyData *) INST_DATA(cl,obj);

    data->str= str;
    data->button=  button;
    data->labelStr= labelStr;
    data->labelButton=  labelButton;

    DoMethod(data->button, MUIM_Notify,
             MUIA_Pressed, FALSE,
             MUIV_Notify_Self, 4,
             MUIM_CallHook,
             &buttonHook,
             data->button,
             data->str);
                         
    return (IPTR)obj;
}
///

///MyDispatcher
DISPATCHER(MyDispatcher)
{
    switch (msg->MethodID)
    {
        case OM_NEW : 
            return mNew(cl,obj,(struct opSet *)msg);
    }

    return(DoSuperMethodA(cl,obj,msg));
}
///

struct MUI_CustomClass *initMUIClass()
{
    return (MUI_CreateCustomClass(NULL, MUIC_Group, NULL, sizeof(struct MyData), ENTRY(MyDispatcher)));
}
                                                                                                 
/****************************************************************************/

/****************************************************************************/
//file main.c
/****************************************************************************/
#include "sys.h"
#include "MUIClass.h"

#ifdef __MORPHOS__
    struct Library *UtilityBase;
#else
    struct UtilityBase *UtilityBase;
#endif

struct IntuitionBase *IntuitionBase;
struct Library *MUIMasterBase;

#ifdef __amigaos4__
    struct UtilityIFace *IUtility;
    struct IntuitionIFace *IIntuition;
    struct MUIMasterIFace *IMUIMaster;
#endif

struct MUI_CustomClass *mcc;

///fail()
void fail(Object *app, STRPTR notice_txt)
{
    struct EasyStruct requester;
        
    if (app)
        MUI_DisposeObject(app);

#ifdef __amigaos4__
    if (IMUIMaster)
        DropInterface((struct Interface *)IMUIMaster);
        
    if (IIntuition)
        DropInterface((struct Interface *)IIntuition);
        
    if (IUtility)
        DropInterface((struct Interface *)IUtility);
#endif

    if (MUIMasterBase)
        CloseLibrary((struct Library *)MUIMasterBase);

    if (IntuitionBase)
        CloseLibrary((struct Library *)IntuitionBase);

    if (UtilityBase)
        CloseLibrary((struct Library *)UtilityBase);


    requester.es_StructSize = sizeof(struct EasyStruct);
    requester.es_Flags      = 0;
        
    if (notice_txt != NULL)
    {
        requester.es_Title        =  "Startup Error";
        requester.es_TextFormat =  notice_txt;
        requester.es_GadgetFormat =  "Exit";
        EasyRequestArgs(NULL, &requester, NULL, NULL);
    }
    else
    {
        requester.es_Title        = "Attention";
        requester.es_TextFormat =  "Closure completed successfully";
        requester.es_GadgetFormat = "Exit";
        EasyRequestArgs(NULL, &requester, NULL, NULL);
    }
}
///

///init()
void init(void)
{
    #ifdef __MORPHOS__
    if ( !(UtilityBase=(struct Library *) OpenLibrary("utility.library",39)) )
    #else
    if ( !(UtilityBase=(struct UtilityBase *) OpenLibrary("utility.library",39)) )
    #endif
    {
        fail(NULL, "Problem! Failed to open\n utility.library");
    }
    else
    {
    #ifdef __amigaos4__
        IUtility = (struct UtilityIFace *) GetInterface((struct Library *)UtilityBase, 
                                "main", 
                                1, 
                                NULL);
    #endif        
    }

    if ( !(IntuitionBase=(struct IntuitionBase *) OpenLibrary("intuition.library",39)) )
    {
        fail(NULL, "Problem! Failed to open\n intuition.library");
    }
    else
    {
        #ifdef __amigaos4__
        IIntuition = (struct IntuitionIFace *) GetInterface((struct Library *)IntuitionBase, 
                                        "main", 
                                        1, 
                                        NULL);
        #endif        
    }

    if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME,19)))
    {
        fail(NULL,"Problem! Failed to open\n MUImaster.library" );
    }
    else
    {
        #ifdef __amigaos4__
        IMUIMaster = (struct MUIMasterIFace *) GetInterface(MUIMasterBase, 
                                        "main", 
                                        1, 
                                        NULL);
        #endif        
    }    
}
///

///main() function                             
int main(int argc,char *argv[])
{
    Object *MyObj, *window, *app;
    

    init();

    if (!(mcc = (struct MUI_CustomClass *) initMUIClass()))
    {
                        fail(NULL,"Problem! Failed to create our class...");
    }


    MyObj = (Object *) NewObject(mcc->mcc_Class, NULL,
                                    MUIA_MUIClassTutorial_TextStr,(ULONG) "Click the button...",
                                    MUIA_MUIClassTutorial_LabelBut,(ULONG) "Click me!",
                                 TAG_DONE);


    window = (Object *) MUI_NewObject(MUIC_Window,
                                        MUIA_Window_Title,(IPTR) "My Window",
                                        MUIA_Window_ID ,MAKE_ID('M','a','i','n'),
                                        MUIA_Window_RootObject, (IPTR) MyObj,
                                      TAG_DONE);
                                        

     app = (Object *) MUI_NewObject(MUIC_Application,
                                        MUIA_Application_Title      ,(IPTR)  "MuiPortableClass",
                                        MUIA_Application_Version    ,(IPTR)  "$VER: MuiPortableClass 1.0",
                                        MUIA_Application_Copyright  ,(IPTR)  " ",
                                        MUIA_Application_Author     ,(IPTR)  "ShInKurO",
                                        MUIA_Application_Description,(IPTR)  "Portable MUI class",
                                        MUIA_Application_Base       ,(IPTR)  "MuiPortableClass",
                                        MUIA_Application_Window, (IPTR) window,
                                       TAG_DONE);
                                        
     

    if (!app)
        fail(app, "Problem! Failed to create app");

    DoMethod(window, 
                MUIM_Notify,
                MUIA_Window_CloseRequest,
                TRUE,
                app,
                2,
                MUIM_Application_ReturnID,
                MUIV_Application_ReturnID_Quit);

    
    SetAttrs(window, MUIA_Window_Open, TRUE, TAG_DONE);
                
    {/*main loop*/
        IPTR sigs = 0;
        while (DoMethod(app, MUIM_Application_NewInput, &sigs) != MUIV_Application_ReturnID_Quit)
        {
            if (sigs)
            {
                sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                if (sigs & SIGBREAKF_CTRL_C) break;
            }
        }
    }

    SetAttrs(window, MUIA_Window_Open,FALSE,TAG_DONE);


    DisposeObject(app);     
    MUI_DeleteCustomClass(mcc);
    fail(NULL, NULL);          

    return 0;
}
///  
/****************************************************************************/
```

## 4.7 DoSuperNew() and variadic functions

DoSuperNew() belongs to the utility functions of MorphOS and allows the programmer
to simplify the creation of methods of new BOOPSI and MUI subclasses.
Obviously, as tradition imposes, DoSuperNew() is not present in other systems,
but then again the SDI Tools authors have put an "indirect" implementation
of this function that employs such headers. The implementation uses the SDI_stdarg.h
and SDI_compiler.h headers. Proceed as follows:

```c
Object * VARARGS68K DoSuperNew(struct IClass *cl, Object *obj, ...)
{
  Object *rc;
  VA_LIST args;

  VA_START(args, obj);
  rc = (Object *)DoSuperMethod(cl, obj, OM_NEW, VA_ARG(args, IPTR), NULL);
  VA_END(args);

  return rc;
} 
```

The VARARGS68K macro (located in the declaration of the function) finds its origin
on AmigaOS4 and its purpose is to indicate the OS4 compiler to manage the variable
number of parameters just like it would be done on AmigaOS3.x. Other compilers,
thanks to the SDI_compiler.h, can safely ignore the VARARGS68K macro.
The macros VA_LIST, VA_START(), VA_ARG() and VA_END() matches respectively
va_list, va_start(), va_arg() and va_end() from the stdarg.h library and have been
"reimplemented" in SDI_stdarg.h so to have a common standard for all the Amiga
variations (they implement the standard ANSI variadic functions differently).

## 4.8 MUI: notification performed using public methods of private classes

After showing the main concepts of a private class creation, we can now
introduce the second model to manage the notifications that we mentioned before
(paragraph 4.5).

First of all it's good to underline the fact that the previous method of notification
employing callbacks hook, under certain circumnstances, could not respect one the
main rules of OOP, the encapsulation, based on the concept of information hiding.
In other words, a class should be a black box (which contents are mostly unknown) that
provides services to the user. However, using hooks and a function connected it is possible
to change from outside the attributes os a class considered private, simply passing them
to the hook.
Using hooks implies using the arithmethic of pointers, which can easily lead to
errors. In order to avoid these issues and respect the OOP paradigm, it is possible
to manage notifications using public methods belonging to our private class.
A method belonging to a class will obviously operate with the class private 
data area (the attributes of said class, that is).

It's also good to remind how in the OOP paradigm a class method is invoked through
a message; in a BOOPSI and MUI world we know that the message is a struct containing
the ID of the method and possibly additional parameters. Let's pick again the example
of paragraph 4.5 where we had a string and a button and we wanted to change their values
when the user clicks the button.
First of all let's declare the ID of our new public method:

```c
#define MUIM_MUIClassTutorial_ClickBut MUI_CLASS_TUTORIAL + 20
```

Now let's declare the method's message:

```c
struct MUIMP_MUIClassTutorial_ClickBut
{
  STACKED ULONG  MethodID;
};
```

In this case the message will only contain its initialization method; in our
example we don't need anything else as the method needs to work with internal
class data. The function that will be associated to the MUIM_MUIClassTutorial_ClickBut
method is nothing but a modified version of the previous "hookPutVal" function.
More precisely, using the callback we had:

```c
HOOKPROTONO(hookPutVal, void, APTR *data)
{

  Object *button, *string;

  button=(Object *) *data++;
  string=(Object *) *data;

  .
  .
  .

}
MakeStaticHook(buttonHook,hookPutVal);
```

now we have a function like that:

```c
IPTR mClickBut(struct IClass *cl, Object *obj, struct MUIMP_MUIClassTutorial_ClickBut *msg)
{

  struct MyData *data;
  data = (struct MyData *) INST_DATA(cl,obj);
  Object *bt_1, *str;

  bt_1=(Object *) data->button;
  str=(Object *)  data->str;

  .
  .
  .

  return (IPTR) obj;
}
```

The difference between the two is apparent. We don't have an explicit use
of pointer arithmetic and our function looks exactly like a class method.
The dispatcher of our private class will now associate the mClickBut()
function the MUIM_MUIClassTutorial_ClickBut ID:

```c
DISPATCHER(MyDispatcher)
{
  switch (msg->MethodID)
  {
    case OM_NEW :
    return mNew(cl,obj,(struct opSet *)msg);

    case MUIM_MUIClassTutorial_ClickBut :
    return mClickBut(cl,obj,(struct MUIMP_MUIClassTutorial_ClickBut *)msg);
  }

  return(DoSuperMethodA(cl,obj,msg));
}
```

Until now we have only declared a new method for our private class, without
any connection to the MUI notification system. To do so, first of all we need
to invoke the already mentioned MUIM_Notify method, that in our previous example
of the callbacks worked like this:

```c
DoMethod(button, MUIM_Notify,
                  MUIA_Pressed, FALSE,
                  MUIV_Notify_Self,
                  4,
                  MUIM_CallHook,
                  &buttonHook,
                  button,
                  string);

while in case of notification using public method we will have:

DoMethod(data->button, MUIM_Notify,
                   MUIA_Pressed, FALSE,
                   obj,
                   1,
                   MUIM_MUIClassTutorial_ClickBut);
```                   

In other words we are using DoMethod() to do the following: "everytime data->button 
object is selected, invoke the MUIM_MUIClassTutorial_ClickBut method on istance obj of 
our private class". This is the resulting code:

```c
/*****************************************************************************/
// file MUIClass.h                             
/*****************************************************************************/

#ifndef __MYMUICLASS__
  #define __MYMUICLASS__

  #define MUI_CLASS_TUTORIAL (TAG_USER+20)

  #define MUIA_MUIClassTutorial_TextStr MUI_CLASS_TUTORIAL + 1
  #define MUIA_MUIClassTutorial_LabelBut MUI_CLASS_TUTORIAL + 2
  #define MUIA_MUIClassTutorial_App MUI_CLASS_TUTORIAL + 3

  struct MUIMP_MUIClassTutorial_ClickBut
  {
    STACKED ULONG MethodID;

  };


  #define MUIM_MUIClassTutorial_ClickBut MUI_CLASS_TUTORIAL + 20

  struct MUI_CustomClass  *initMUIClass();
#endif
/*****************************************************************************/

/*****************************************************************************/
//file MUIClass.c
/*****************************************************************************/
struct MyData
{
  Object *button, *str;
  STRPTR labelButton, labelStr;
};


///OM_NEW
static IPTR mNew(struct IClass *cl,Object *obj,struct opSet *msg)
{

  STRPTR labelStr, labelButton;
  Object *str, *button;
  struct TagItem *tags =((struct opSet *)msg)->ops_AttrList;
    
  labelStr= (STRPTR) GetTagData(MUIA_MUIClassTutorial_TextStr, (IPTR)" ",tags);

  labelButton= (STRPTR) GetTagData(MUIA_MUIClassTutorial_LabelBut, (IPTR)" ",tags);
      
  str = MUI_NewObject(MUIC_String,
                      MUIA_Frame, MUIV_Frame_String, 
                      MUIA_String_Contents,(IPTR) labelStr,
                      TAG_DONE);
    
  button= (Object *) MUI_MakeObject(MUIO_Button,(IPTR) labelButton, TAG_DONE);
                    
  obj = (Object *) DoSuperNew(cl, 
            obj,
            MUIA_Group_Child, str,
            MUIA_Group_Child, button,
            TAG_MORE, msg->ops_AttrList);

  if (obj==NULL)
    return 0;
    
  {
    struct MyData *data;
    data = (struct MyData *) INST_DATA(cl,obj);

    data->str = str;
    data->button = button;
    data->labelStr = labelStr;
    data->labelButton = labelButton;

    DoMethod(data->button, MUIM_Notify,
                           MUIA_Pressed, FALSE,
                           obj,
                           1,
                           MUIM_MUIClassTutorial_ClickBut);
  }


  return (IPTR)obj;
}
///

/// MUIM_MUIClassTutorial_ClickBut
static IPTR mClickBut(struct IClass *cl,Object *obj, struct MUIMP_MUIClassTutorial_ClickBut *msg)
{

  struct MyData *data;
  Object *bt_1, *str;

  data = (struct MyData *) INST_DATA(cl,obj);
  bt_1=(Object *) data->button;
  str=(Object *)  data->str;

 

  SetAttrs(str,  MUIA_String_Contents,(IPTR) "Button clicked", TAG_DONE);
  SetAttrs(bt_1, MUIA_Text_Contents,(IPTR) "Clicked!", TAG_DONE);
  SetAttrs(bt_1, MUIA_Disabled,TRUE, TAG_DONE);
 
  return (IPTR) obj;
}
///

///MyDispatcher
DISPATCHER(MyDispatcher)
{
  switch (msg->MethodID)
  {
    case OM_NEW :
		return mNew(cl,obj,(struct opSet *)msg);
    case MUIM_MUIClassTutorial_ClickBut :
		return mClickBut(cl,obj,(struct MUIMP_MUIClassTutorial_ClickBut *)msg);
  }

  return(DoSuperMethodA(cl,obj,msg));
}
///

///initMUIClass()
struct MUI_CustomClass  *initMUIClass()
{
  return (struct MUI_CustomClass *) MUI_CreateCustomClass(NULL, MUIC_Group, NULL, 
		sizeof(struct MyData), ENTRY(MyDispatcher));

}
///
/*****************************************************************************/
```

### 4.8.1 MUI: notification through notifiable attributes

We have already mentioned the case where changing the value of an attribute leads to
the execution of an action. In our case the attribute was already provided by the
MUI class that we were using, more precisely we are referring to the MUIA_Pressed
attribute.
We could think that changing a value of any attribute of a MUI class triggers
our function according to the above mentioned rules, but this is not completely true.
Actually only some attributes of each of MUI classes can trigger an action everytime 
their value changes.
First of all let's explicit a concept we have only silently expressed: an
attribute is defined "notifiable" when it allows plugging an action on any
change of its value. As we said, not every attribute provided by a MUI class
is notifiable; moreover attributes of our private classes are not notifiable
unless we explicitely make them so.
There are specific rules to respect in case we want to make an attribute of
our private class notifiable, so to be able to plug it to an action triggered
by some other class. To better understand, now it's time to list the object
packet (the message) of the OM_GET method:

```c
struct opGet
{
  STACKED ULONG  MethodID;      /*OM_GET                             */
  STACKED Tag    opg_AttrID;    /*attribute to be read               */
  STACKED IPTR   *opg_Storage;  /*memory area that contains          */
                                /*the attribute value requested      */ 
};
```
 
The message handling by the Get method of a class is quite easy: the function 
designated to overload the OM_GET method will simply check if inside opg_AttrID there
is the ID of an attribute belonging to its own class.
If the answer is positive, the function will use the opg_Storage memory area,
putting the value of the requested attribute; finally the function will return TRUE.
This latest value, according to BOOPSI rules, indicates that the operation succeded.
If, on the other hand, opg_AttrID does not contain any known attribute, the function
will push the message upwards to the superclass, as usual.

We have now explained the main steps concerning the OM_GET method because the first
and most important rule of MUI to obtain an notifiable attribute is to make it readable
"outside", or - using a better word - our attribute must be "gettable".

Obviously we need our attribute to trigger a notification only if the new value
is not equal to the current value of the attribute. For example, if our
attribute's value is TRUE, we don't want to be informed that it is being
"changed" again to TRUE. In order to do so, there's only to overwrite the ID in the 
ti_Tag field of our attribute's OM_SET message with TAG_IGNORE. This way we will also
avoid weird situations.

Now we have all the theoretical elements to make our attribute notifiable, so
there's only to show a practical example.

Let's say the we have three classes, binded by a hierarchical link: Class1
and Class2 are known to Class3 but they're in direct contact. This could be a
representation of these relationship:

	Classe1--->Classe3<---Classe2

Each of these classes has a private data area which is only known to each other,
respecting the concept of information hiding. Let's also suppose that each of
these classes has its own set of attributed and public methods.
Now we want that when the value of the MUIA_Class1_Attr1 attribute changes to TRUE, 
Class2 executes its own MUIM_Class2_Method2 method.
First of all, concerning Class1 we will have a situation like the following:

```c
*******************************************************************************
struct dataArea1
{
  LONG attr1;
  ....
};

*******************************************************************************
....
//method OM_GET
IPTR GetClass1(struct IClass *cl,Object *obj,struct opGet *msg)
{
  struct dataArea1 *data = INST_DATA(cl, obj);

  switch (msg->opg_AttrID)
  {
    case MUIA_Class1_Attr1:
      *msg->opg_Storage = (LONG) data->attr1;
      return TRUE;

    ...
  }

  return DoSuperMethodA(cl,obj,(Msg)msg);
}                                         
*******************************************************************************

//method OM_SET
IPTR SetClass1(struct IClass *cl,Object *obj,struct opSet *msg)
{
  struct dataArea1  *data = INST_DATA(cl,obj);

  {/*code block to read the tags list*/
    struct TagItem *tags, *tag;
    tags=((struct opSet *)msg)->ops_AttrList;

    while (tag=NextTagItem((TAGITEM)&tags))
    {
      switch (tag->ti_Tag)
      {
        case MUIA_Class1_Attr1:
         if (data->attr1==tag->ti_Data) tag->ti_Tag = TAG_IGNORE;
        else                                                                        
          data->attr1 = (LONG) tag->ti_Data;
        break;

        ...
      }
    }
  }

  return DoSuperMethodA(cl,obj,(Msg)msg);
}
....
 
*******************************************************************************
```

In this way the attribute MUIA_Class1_Attr1 notifies its own status change from
outside Class1. In order to trigger MUIM_Class2_Method2 let's suppose we have 
instanced two objects inside Class3, one from Class1 and the other from Class2:


```c
....

Object *obj1, *obj2;

obj1 = NewObject(Class1->mcc_Class,  NULL, TAG_DONE);
obj2 = NewObject(Class2->mcc_Class,  NULL, TAG_DONE);

....
```

Now we only have to link the notification as usual:

```c
DoMethod(obj1,  MUIM_Notify,
        MUIA_Class1_Attr1, TRUE,
        obj2,
        1,
        MUIM_Class2_Method2);
```        

### 4.8.2 MUI: notification chains

In paragraph 4.8.1 we have learned how to make notifiable an attribute of
our class. Often we have a hierarchy of classes where a class on top of it should
be notified of a value changed in an attribute of one of its subclasses.
Let's see the following example of class hierarchy:

	Class1-->Class2-->Class3

Class3 does not know about Class1 since our system respects the incapsulation
and information hiding paradigm.
Class2 has an attribute (MUIA_Class2_Attr2) which value can be that of a Class1 
attribute (MUIA_Class1_Attr1).
Also, Class3 has an attribute (MUIA_Class3_Attr3) which value can be taken from
a Class2 attribute (MUIA_Class2_Attr2).

In other words we have a class relationship in which changing value to attribute
MUIA_Class1_Attr1 triggers a notification in Class2 attribute MUIA_Class2_Attr2;
same thing happens for Class3 attribute MUIA_Class3_Attr3.
We observe that Class3 has an instance of Class2 and Class2 has an instance of
Class1:

```c
MUIA_Class1_Attr1 = MUIA_Class2_Attr2 = MUIA_Class3_Attr3
```

In order to make all this work, the first thing to do is describe the OM_GET and
OM_SET methods for each one of these three classes, just like in paragraph 4.8.1.
We will have a "instance1" object that will be our instance of Class1 inside Class2;
then, somewhere in Class2 (usually inside the OM_NEW method) we need the notification:

```c
DoMethod(instance1, MUIM_Notify,
           MUIA_Class1_Attr1, MUIV_EveryTime,
           obj,
           3,
           MUIM_Set,
           MUIA_Class2_Attr2,
           MUIV_TriggerValue);
```

MUIV_EveryTime is a special MUI value that instucts the system to catch any valid
change (an actual change of value, that is) in MUIA_Class1_Attr1 attribute value.
MUIM_Set is nothing but our OM_SET method a bit modified: as we know, OM_SET
requires a taglist, but building such a parameter would be a bit tedious. This is
why MUI offers the MUIM_Set method; it allows to pass parameters without the need
of a taglist, just like in the previous example.
MUIV_TriggerValue is another special value that tells the system to pass on to
a method, in our case MUIM_Set, any value that is being notified through
MUIV_EveryTime.
Basically MUI replaces MUIV_TriggerValue with the value that triggered the
notification.

Same behaviour will be observed for MUIA_Class2_Attr2 and MUIA_Class3_Attr3 while
building the following notification:

```c
DoMethod(instance2, MUIM_Notify,
           MUIA_Class2_Attr2, MUIV_EveryTime,
           obj,
           3,
           MUIM_Set,
           MUIA_Class3_Attr3,
           MUIV_TriggerValue);
```           

Now, everytime MUIA_Class1_Attr1 will change value, this event will trigger
a reaction also on MUIA_Class2_Attr2 and MUIA_Class3_Attr3 attributes.

As the last thing, we can now implement in a different way the example shown
in paragraph 4.5.1, without using hooks or new methods of the class to be defined.
We will only need three notifications: in the example from paragraph 4.5.1 we
had a button, a string and three attributes that changed when MUIA_Pressed value
changed.
We can accomplish all that with the following code:

```c
DoMethod(button, MUIM_Notify,
          MUIA_Pressed, FALSE,
          string,
          3,
          MUIM_Set,
          MUIA_String_Contents,
          "Clicked button");  

DoMethod(button, MUIM_Notify,
          MUIA_Pressed, FALSE,
          button,
          3,
          MUIM_Set,
          MUIA_Text_Contents,
          "Clicked!");

DoMethod(button, MUIM_Notify,
          MUIA_Pressed, FALSE,
          button,
          3,
          MUIM_Set,
          MUIA_Disabled,
          TRUE);
```

### 4.8.3 MUI: warnings about using notified attributes
 
In paragraph 4.8.2 we have realized a couple of notifications that in some
way connected three classes to each other:

	Class1-->Class2-->Class3

This connection is one-way only since the attribute notification goes from
Class1 to Class3. Sometimes we would like to also notify MUIA_Class1_Attr1
when MUIA_Class3_Attr3 changes.
In order to do so we would need to synchronize these value changes, having these
notifications go back and forth; however such connections would lead to an
endless loop of the MUI notification facility offered by MUI:

	  -->Class1-->Class2-->Class3--
	  |                            |
	  -------------Class2<---------

If we want to overcome this limitation, we should "break" the loop where it
makes sense: on the one hand, when the value change of MUIA_Class1_Attr1 reaches
Class3 and, on the other, when the value change of MUIA_Class3_Attr3 reaches
Class1; after reaching the designated class and setting the destination attribute 
accordingly, both notifications will stop.
To do so, we should provide a piece of code like the following:

```c
DoMethod(obj, MUIM_Notify,
              MUIA_Class3_Attr3, MUIV_EveryTime,
              instance2,
              3,
              MUIM_Set,
              MUIA_Class2_Attr2,
              MUIV_TriggerValue);

DoMethod(instance2, MUIM_Notify,
           MUIA_Class2_Attr2, MUIV_EveryTime,
           obj,
           3,
           MUIM_NoNotifySet,
           MUIA_Class3_Attr3,
           MUIV_TriggerValue);
```           

The first function call to MUIM_Notify it's easy to understand: basically we have
linked the value changing of MUIA_Class3_Attr3 to MUIA_Class2_Attr2; we are
propagating our notification from Class3 to Class2.
Same thing must be done in Class2 in order to propagate the notification to Class1.
In the second function call to MUIM_Notify we have used MUIM_NoNotifySet instead of
MUIM_Set.

The MUIM_NoNotifySet method executes the same actions of MUIM_Set without notifying
MUI about the changes that are being performed to a certain attribute.
In other words we have performed the first interruption on our notification loop.
Now we have to perform the second interruption, which will be in Class2:

```c
DoMethod(obj,   MUIM_Notify,
                MUIA_Class2_Attr2, MUIV_EveryTime,
                instance1,
                3,
                MUIM_NoNotifySet,
                MUIA_Class1_Attr1,
                MUIV_TriggerValue);
```                

#### 4.8.3.1 Warnings about chained notifications in Zune

MUI recognizes and manages accordingly the case where there are chained notifications.
In other words, in a situation like the following:

	 -->MUIA_Class1_Attr1 --> MUIA_Class2_Attr2 --> MUIA_Class3_Attr3--> MUIA_Class4_Attr4-->
	 |                                                                                      |
	(#)                                                                                    (#)
	 |                                                                                      |
	 <--MUIA_Class1_Attr1 <-- MUIA_Class2_Attr2 <-- MUIA_Class3_Attr3<-- MUIA_Class4_Attr4<--
 
where (#) represents the loop interruption provided by MUIM_NoNotify_Set, MUI automatically 
breaks the "subloops" that could be generated in between the notifications. To better 
understand, in the above situation the following subloop could show up:

	 -->MUIA_Class2_Attr2 --> MUIA_Class3_Attr-->
	 |                                          |
	 |                                          |
	 <--MUIA_Class2_Attr2 --> MUIA_Class3_Attr<-- 

In this case MUI 3.8+ breaks the subloop, preventing any possible unwanted interaction between 
notifications, without breaking the notification chain.

All this does not happen with Zune. In the latest versions Zune recognizes loops,
but the countermeasures are not as quick as in MUI.
As a workaround of this "bug", in Zune there is a further action to be performed,
besides the two MUIM_NoNotifySet at the end of the loops; the developer has also to
decouple the attributes in use.
In other words, when possible, the same attributes should have different labels. In
our example:

	 -->MUIA_Class1_Attr1 --> MUIA_Class2_Attr2_X --> MUIA_Class3_Attr3_X --> MUIA_Class4_Attr4-->
	 |                                                                                           |
	(#)                                                                                         (#)
	 |                                                                                           |
	 <--MUIA_Class1_Attr1 <-- MUIA_Class2_Attr2_Y <-- MUIA_Class3_Attr3_Y <-- MUIA_Class4_Attr4<--
 
In this example MUIA_Class2_Attr2_X equals MUIA_Class2_Attr2_Y and MUIA_Class3_Attr3_X equals
MUIA_Class3_Attr3_Y.
What is actually needed is to declare new labels that in the OM_SET and OM_GET methods
will be used to execute the same actions as of the original labels.
Of course this approach works fine in MUI too, therefore it should be the preferred
method in case of portable applications.

## 4.9 MUI: synchronizations, MUIM_Application_PushMethod and MUIM_Application_KillPushMethod

MUI provides that all notifications triggered while iterating the main event control loop
(see paragraph 4.5.2) will be executed inside the current iteration.
What is not guaranteed, however, is the order these notifications will be
executed. Let's see two examples of chain notifications:

	Class1_AttrA --> Class2_AttrA --> Class3_AttrA  --> Class4_AttrA

and

	Class1_AttrB --> Class2_AttrB --> Class3_AttrB  --> Class4_AttrB

MUI will guarantee that Class4_AttrA and Class4_AttrB will eventually be
notified of the value change of (respectively) Class1_AttrA and Class1_AttrB
during an iteration of the event control loop, but it doesn't guarantee which
one will be notified first or last. In other words, the two following instructions:

```c
SetAttrs(objFromClass1, Class1_AttrA, value1, TAG_DONE);
SetAttrs(objFromClass1, Class1_AttrB, value2, TAG_DONE);
```

can be equally given in opposite order:

```c
SetAttrs(objFromClass1, Class1_AttrB, value2, TAG_DONE);
SetAttrs(objFromClass1, Class1_AttrA, value1, TAG_DONE);
```

and it will be exactly the same. The order MUI will set the attributes Class4_AttrA
and Class4_AttrB is not predictable.

This is especially visible in case of long chained notifications with many
methods involved. Although in our code notifications are triggered in a
logical order, it is possible that they will not be executed according to that
order.
It is therefore very important to avoid assumptions about the order execution
of our algorithms when they involve notification chains.

It is however possible to maintain a certain degree of order execution also in
case of long notification chains using a special method, which main use is not
connected to notifications: MUIM_Application_PushMethod.

MUIM_Application_PushMethod takes as parameters a method along with its arguments and
incapsulate them in a private data area of the MUIC_Application object that had
invoked said method. The encapsulated method is therefore maintained until the
following iteration of the event control loop, actually slowing down its execution.

In other terms, suppose considering the nth iteration of the event control loop,
we can write the following code:

```c
LONG pushIDFoo = 0, pushIDBar= 0;

pushIDFoo = DoMethod(objApp, MUIM_Application_PushMethod, 
                        objFooClass1, 
                        3, 
                        MUIM_Set, 
                        Class1_AttrA, 
						value1);

pushIDBar = DoMethod(objApp, MUIM_Application_PushMethod, 
                        objBarClass1,
                        3, 
                        MUIM_Set, 
                        Class1_AttrB, 
						value2);
```

this way the attribute Class4_AttrA will be set during the nth+1 iteration of
the control loop, and the attribute Class4_AttrB will be set during the
the nth+2 iteration of the control loop.

Starting with MUI 3.9, MUIM_Application_PushMethod returns a value that identifies the method
put into the memory area. This value is useful in case we would like to manually remove
that very method that is being "pushed".

It's important to note that the private memory area we mentioned before can be
easily filled up if MUIM_Application_PushMethod is invoked too many times before
the following iteration of the event control loop occurs.

When this buffer is all used, unpredictable situations can arise, a MUI crash
in the worst case. For example when invoked inside our subclass MUIM_Draw method,
or when there are many OM_SET calls to set an attribute.

In other terms, these dangerous situations show up when the attribute is set to
a temporary value many times before being set to its final value (imagine the
various interim values indicating the position of a scroller).
In order to avoid all this, and in this case only, it is possible to use a
non-documented MUI method (supported by Zune too) which definition is as follows:

```c
#define MUIM_Application_KillPushMethod 0x80429954
```

By invoking this method we will manually remove from the buffer the previous
methods archived for a certain object. Starting from MUI 3.9, as mentioned before,
it is possible to perform a specific method removal, using the return value of the
method MUIM_Application_PushMethod.
In case of previous versions of MUI or Zune, this value will be ignored and the
last method pushed to the buffer will be removed (the MUIM_Application_PushMethod
method returns TRUE on MUI 3.8 and Zune if the method linked to it has been added
to the private buffer).
Our previous code will turn into the following:

```c
if (pushIDFoo)
{
    DoMethod(objApp, MUIM_Application_KillPushMethod,
				objFooClass1,
				pushIDFoo);

    pushIDFoo = 0;
}

pushIDFoo = DoMethod(objApp, MUIM_Application_PushMethod, 
                        objFooClass1,
                        3, 
                        MUIM_Set, 
                        Class1_AttrA,
						value1);

if (pushIDBar)
{
    DoMethod(objApp, MUIM_Application_KillPushMethod, 
              objBarClass1, 
             pushIDBar);

    pushIDBar=0;
}

pushIDBar = DoMethod(objApp, MUIM_Application_PushMethod, 
                        objBarClass1, 
                        3, 
                        MUIM_Set, 
                        Class1_AttrB,
						value2);
```						

Of course this piece of code also works in case of MUI 3.9 and earlier versions,
Zune included, since the "pushIDxxxx" of the message definition of the earlier
versions of MUIM_Application_KillPushMethod have that flag set to zero.

## 4.10 MUI: a bit more about hooks (private methods and notifications)

Until now we have learned how to implement public attributes and methods for
our classes, without expliticing the concept of private attributes and methods.
It is clear that private attributes and methods are nothing but variables
and functions used inside a class itself. We know how the BOOPSI standard
identifies public attributes and methods through symbols we declare; think of
our previous examples: MUIM_MUIClassTutorial_ClickBut, MUIA_Class1_Attr1 and
so on.

We have also shown the so called notifiable attributes, that are simply
public attributes implemented following specific rules that allow alerting
MUI of their value change.
Actually we have already mentioned how to manage private attributes and
methods: using hoooks (paragraph 4.5.1). Using a hook allows us declaring
a function just like a public method, without having this new function to be
known outside the class itself, according to BOOPSI ruling.
In other words, if used correctly, hooks can be a powerful tool to improve
the encapsulation of our class, as long as the hook is not reachable from
outside the class that is implementing and using it.

In our first example, where we had a button and a string linked through a
notification, we were inside the class that declared these objects, therefore
using a hook to implement the notification would have been the best solution.
On the other hand, when we have to connect two objects belonging to two different
classes, our choice would be to implement the notification through a public method
or a notifiable attribute.

Now let's recap briefly, we have learned that a MUI class can have:

- Private attribute:	these are variables declared inside the private data area of our
						class and are not associated with any symbol.

- Public attribute:		these are variables (usually) declared inside the data area of the
						class and they are associated in OM_NEW/OM_SET/OM_GET to symbols
						(e.g. MUIA_Class1_Attr1).

- Notifiable attributes:	these are public attributes which value change is catched and/or
							modified by MUI through methods such as MUIM_Notify and MUIM_Set.

- Private methods:		these are utility functions, defined and used inside a class, but not
						associated to any symbol;

- Private methods linkable
  to notifications:		these are functions associated to hooks, listening to the value change
						of notifiable attributes through methods such as MUIM_Notify and
						MUIM_CallHook;

- Public methods:		these are functions declared and defined that are associated in the
						class dispatcher to symbols (e.g. MUIM_MUIClassTutorial_ClickBut) and
						linked to notifiable attributes through MUIM_Notify;

## 4.11 MUI macro shortcuts

On many occasions, while being compliant to the OOP paradigm, there are
objectively problems, let's think of the already mentioned MUIM_Application_PushMethod.
This method belongs to the MUIC_Application class, but in many cases it would be
also useful using it inside objects of our subclasses from an instance of
MUIC_Application, even though - in theory - these objects should not be allowed
to directly communicate with the instance.

When such an situation (and many other) occurs, instead of passing important
addresses through subclasses that are not supposed to know that kind of external
detail, it is possible to use the so called MUI shortcuts.
It is not advisable to always use these shortcuts, you have to know what you're
doing; also - from a theoretical standpoint - they break the OOP paradigm.
In brief, pay attention to avoid creating spaghetti-code.

Let's make another example: suppose we have a generic "obj" object. Some of the
most used MUI shortcuts are:

```c
_app(obj) = returns the MUIC_Application instance containing our object;
_win(obj) = returns the MUIC_Window instance containing our object;
```

Namely these two shortcuts are usable only after the MUIM_Setup has been invoked
from our MUI subclass and before MUIM_Cleanup has been invoked.
So, for example, if these shortcuts are being used inside a OM_NEW or OM_DISPOSE
method the application would crash.

Although these MUI shortcuts has been provided to create low level graphic classes
(just have a look at the sources of some MUI classes like TextEditor MCC and similar
classes), by using them our code is able to invoke methods outside of our subclass
without getting us mad trying.

It is suggested to read the mui.h header to find all the available MUI shortcuts and
learn when they can be used.
