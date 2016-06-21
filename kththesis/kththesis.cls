\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kththesis}[2016/06/21 KTH Thesis formatting /Örjan Ekeberg]

\newif\ifinswedish
\DeclareOption{english}{}
\DeclareOption{swedish}{\inswedishtrue}

\newif\ifbachelor
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{}

%% Send any unknown option to the report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\LoadClass[11pt]{report}

%% Load other packages
\RequirePackage[swedish,english]{babel}
\RequirePackage[a4paper,twoside,
  top=30mm,bottom=30mm,inner=36mm,outer=18mm,
  headsep=10mm,headheight=5mm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{emptypage}
\RequirePackage{titlesec}
\RequirePackage{ragged2e}

\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxeorlua
\ifxetex\xeorluatrue\fi
\ifluatex\xeorluatrue\fi

\ifxeorlua
  \RequirePackage{fontspec}
  \setmainfont{FreeSerif}
  \setsansfont{FreeSans}
  \setmonofont{FreeMono}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{palatino}
\fi

% Set up the header and footer
\fancyhead{}
\fancyhead[RO]{\sffamily\small\leftmark\qquad\thepage}
\fancyhead[LE]{\sffamily\small\thepage\qquad\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% The Palatino font needs 5% extra linespacing
\linespread{1.05}
\setlength\RaggedRightParindent{\parindent}
\RaggedRight

% Set the proper format for the headers
\titleformat{\chapter}[display]
  {\normalfont\sffamily\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries}
  {\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\sffamily\large\bfseries}
  {\thesection}{1em}{}

\renewenvironment{abstract}{\section*{\abstractname}}{\clearpage}

% Define commands for setting the user definable parts of the title page
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\examiner}[1]{\def\@examiner{#1}}
\let\@secondauthor\@empty
\newcommand{\secondauthor}[1]{\def\@secondauthor{#1}}
\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}

% Command to print out the title page
\renewcommand{\titlepage}{
\newgeometry{top=65mm,bottom=30mm,left=62mm,right=18mm}
\thispagestyle{empty}
\ifinswedish\selectlanguage{swedish}\fi
\begin{huge}
  \noindent\sffamily\bfseries \@title \par
\end{huge}
\ifx\@subtitle\@empty\relax
\else
\begin{Large}
  \vspace{1ex}
  \noindent\sffamily\bfseries \@subtitle \par
\end{Large}
\fi

\vspace{10mm}
\begin{large}
  \begin{flushleft}
    \sffamily
    \expandafter\MakeUppercase\expandafter\@author \par
    \ifx\@secondauthor\@empty\relax
    \else\vspace{1ex}\expandafter\MakeUppercase\expandafter\@secondauthor \par
    \fi
  \end{flushleft}
\end{large}

\vfill

\begin{flushleft}
  \sffamily
  \ifinswedish
    Examensarbete, \ifbachelor grundnivå\else avancerad nivå\fi\\
    Handledare: \@supervisor\\
    Examinator: \@examiner\\
    Skolan för datavetenskap och kommunikation\\
  \else
    \ifbachelor Batchelor\else Master\fi 's Thesis\\
    Supervisor: \@supervisor\\
    Examiner: \@examiner\\
    School of Computer Science and Communication\\
  \fi
\end{flushleft}
\restoregeometry

\pagenumbering{roman}
\clearpage
}

% Command to print out the title in the alternative language (Swedish/English)
\newcommand{\alttitle}[1]{%
  \begin{huge}
    \noindent\sffamily\bfseries #1 \par
  \end{huge}
}

\newcommand{\frontmatter}{
  \cleardoublepage
  \tableofcontents
  \cleardoublepage
  \pagenumbering{arabic}
}

\endinput
