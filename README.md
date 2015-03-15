# Guide to Amiga Compatible Programming

With the passing of the years Amiga programming becomes a black magic because documentation on this system is no longer being updated and documentation on new systems like AmigaOS4, MorphOS and AROS does not really target cross platform application development. This guide tries to introduce the reader in Amiga programming following modern techniques that are available for all different systems.

This version of the guide is a fork of the orignal guide that was done by Gianfranco "ShInKurO" Gignina and many contributors. 

The original version is/was located here:

https://code.google.com/p/guidetoamigacompatibleprogramming/

Anyway while Google Code will be discontinued, a copy of the original documents in all languages will be kept in the repository.

## What has changed?

This fork mainly targets new formatting. The plain text files have been converted into Markdown format which improves readability and converting to other formats like HTML and PDF.

Note that the original version of this guide was done in Italian and then translated to english. This fork only focuses on the English version. 

## Converting Markdown to HTML (example)

For converting the guide into e.g. HTML the Pandoc document converter is recommended:

	pandoc --mathml --highlight-style tango -s -t html CAP_0.md CAP_1.md CAP_2.md CAP_3.md CAP_4.md X_APP_B.md > guide.html
	
For convenience a HTML version is part of this repository.

## License

Content license
Creative Commons 3.0 BY-SA

Code license
Artistic License/GPL

--

Amiga® is a trademark of Amiga Inc. Workbench® is a trademark of Cloanto Italia srl. All other trademarks belong to their respective owners.
