%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% labmanual.cls - Custom LaTeX class for laboratory manuals
% Created: 2024/10/24
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{labmanual}[2024/10/24 Custom article class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options and Base Class Loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{journal}}
\ProcessOptions\relax
\LoadClass[10pt]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font packages
\usepackage[scaled=1.0]{helvet}
\usepackage[letterspace=500]{microtype}
\usepackage[scaled=0.85]{beramono}
\usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}

% Math and science packages
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage[version=4]{mhchem}
\usepackage{stmaryrd}

% Layout and formatting packages
\usepackage{parskip}
\usepackage{geometry}
\usepackage{fancyhdr}
\usepackage{float}
\usepackage{newfloat}
\usepackage{array}
\usepackage{multicol}
\usepackage{paracol}
\usepackage{longtable}
\usepackage{booktabs}
\usepackage{makecell}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{wrapfig}
\usepackage{enumitem}
\usepackage{flafter}

% Code and verbatim packages
\usepackage{fancyvrb}
\usepackage{bold-extra}
\usepackage{verbatim}
\usepackage[formats]{listings}

% Graphics and color packages
\usepackage{graphicx}
\usepackage[export]{adjustbox}
\usepackage{xcolor}
\usepackage{tikz}
\usepackage[most]{tcolorbox}
\usepackage[framemethod=TikZ]{mdframed}

% Utility packages
\usepackage{soul}
\usepackage{varioref}
\usepackage{hyperref}
\usepackage{xparse}
\usepackage{xstring}
\usepackage{environ}
\usepackage{chngpage}
\usepackage{collect} % for the aside env

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup (Evaluated First)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\@oldtitle\title
\renewcommand{\title}[1]{%
    \gdef\@mytitle{#1}%
    \@oldtitle{#1}%
}

% Make captions numbered by section
\captionsetup{within=section}

% Remove ugly borders around links
\hypersetup{
    colorlinks,
    linkcolor={red!10!black},
    citecolor={blue!50!black},
    urlcolor=[cmyk]{.6,.9,0,.7} % Purple
}

% Frame spacing
\mdfsetup{skipabove=1em,skipbelow=1em}

%% Load tikz libraries
\usetikzlibrary{calc} % For performing calculations
\usetikzlibrary{positioning} % For dynamic positioning (requires calc)
\usetikzlibrary{arrows}    % For arrow tips
\usetikzlibrary{shadows.blur}   % For blur shadows


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Color and Style Definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{black}{rgb}{0,0,0}
\definecolor{yellow}{rgb}{1, 0.89, 0.36}
\definecolor{blue}{rgb}{0.49803922, 0.78431373, 0.97254902}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

%% Frame Styles (Colored Boxes)
\mdfdefinestyle{extrastyle}{
    backgroundcolor=blue!50,
    roundcorner=10pt,
    linewidth=1pt,
    linecolor=black,
    frametitlebackgroundcolor=blue!60,
    frametitleaboveskip=10pt,
    frametitlebelowskip=5pt,
    frametitlerule=false,
    frametitlerulecolor=blue,
    nobreak=true
}

\mdfdefinestyle{importantstyle}{
    backgroundcolor=red!50,
    roundcorner=10pt,
    linewidth=1pt,
    linecolor=black,
    frametitlebackgroundcolor=red!60,
    frametitleaboveskip=10pt,
    frametitlebelowskip=5pt,
    frametitlerule=false,
    frametitlerulecolor=red,
    nobreak=true
}

\mdfdefinestyle{questionstyle}{
    backgroundcolor=yellow!40,
    roundcorner=10pt,
    linewidth=1pt,
    linecolor=black,
    frametitlebackgroundcolor=yellow!50,
    frametitleaboveskip=10pt,
    frametitlebelowskip=5pt,
    frametitlerule=false,
    frametitlerulecolor=black,
    nobreak=true,
}

%% Listing Styles (code boxes)

% Console style
\lstdefinestyle{console}{
    keywordstyle=\color{black},
    commentstyle=\color{codegray},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2
}

% Default code style
\lstdefinestyle{defaultstyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2
}

\lstdefineformat{V}{~=\( \sim \)}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typography and Spacing Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set default font to sans-serif
\renewcommand{\familydefault}{\sfdefault}

% Hyphenation settings
\hyphenpenalty=5000      % Makes hyphenation very unlikely
\exhyphenpenalty=10000   % Makes hyphenation of already-hyphenated words very unlikely

% Paragraph formatting
\setlength{\parindent}{0pt}
\setlength{\parskip}{1\baselineskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List Environment Modifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save original list environments
\let\olditemize\itemize
\let\endolditemize\enditemize
\let\oldenumerate\enumerate
\let\endoldenumerate\endenumerate

% Modify itemize environment
\renewenvironment{itemize}{%
    \setlength{\parskip}{.5em}%
    \olditemize
}{%
    \endolditemize
    \setlength{\parskip}{1\baselineskip}%
}

% Modify enumerate environment
\renewenvironment{enumerate}{%
    \setlength{\parskip}{.5em}%
    \oldenumerate
}{%
    \endoldenumerate
    \setlength{\parskip}{1\baselineskip}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Float Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General parameters for all pages
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.8}

% Parameters for text pages
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{2}
\renewcommand{\dbltopfraction}{0.9}
\renewcommand{\textfraction}{0.07}

% Parameters for float pages
\renewcommand{\floatpagefraction}{0.7}
\renewcommand{\dblfloatpagefraction}{0.7}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Utility commands

% Create a command to set up the headers
\newcommand{\makeheaders}{%
    \setlength{\headheight}{15.2pt}%
    \pagestyle{fancy}%
    \fancyhf{}%
    \fancyhead[R]{ECE/CS 3700}%
    \fancyhead[L]{\@mytitle}%
}
\newcommand{\code}[1]{\textbf{\texttt{#1}}}
\newcommand{\keyword}[1]{{\usefont{OT1}{lmtt}{b}{n}#1}}
\newcommand{\todo}[1]{\hl{\textbf{TODO: #1}}}
\NewDocumentCommand{\directions}{>{\SplitList{,}}m}{%
  \begingroup
  \bfseries
  \def\mylastitem{}%
  \def\directionitem##1{%
    \ifx\mylastitem\empty
     {}%
    \else
      \mylastitem
      \nobreak\hspace{0.5em}$\rightarrow$\nobreak\hspace{0.5em}%
    \fi
    \def\mylastitem{##1}%
  }%
  \ProcessList{#1}{\directionitem}%
  \mylastitem% Print the last item without an arrow
  \endgroup
  \normalfont
}

% Roman section numbering
\newcounter{romansectioncounter}
\newcommand{\romansection}[1]{%
    \edef\originalsection{\arabic{section}}%
    \renewcommand{\thesection}{\roman{section}}%
    \setcounter{section}{\value{romansectioncounter}}%
    \section{#1}%
    \stepcounter{romansectioncounter}%
    \renewcommand{\thesection}{\arabic{section}}%
    \setcounter{section}{\originalsection}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom Environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Code block environment (prevents page breaks in code blocks)
\lstnewenvironment{codeblock}[1][]
    {\leavevmode\hfill\break\vspace{\baselineskip}\minipage{\linewidth}\lstset{#1}}
    {\endminipage\leavevmode\hfill\break\vspace{\baselineskip}\ignorespacesafterend}

% Questions section environment
\NewDocumentEnvironment{questionssection}{}{%
    \setcounter{questioncounter}{0}%
    \romansection{Questions}%
    \vspace{1em}%
    \begin{important}%
    The questions in this section are a collection of the questions found in context throughout the lab manual. This is for convenience while working through the lab. Each question need only be answered once.%
    \end{important}%
}{%
    \setcounter{questioncounter}{0}%
    \setcounter{bonusquestioncounter}{0}%
}

% Question environments
\newcounter{questioncounter}
\newcounter{bonusquestioncounter}

\NewDocumentEnvironment{question}{o}{%
    \stepcounter{questioncounter}%
    \addcontentsline{toc}{subsection}{Question \thequestioncounter: \IfNoValueTF{#1}{Default Title}{#1}}%
    \begin{mdframed}[
        style=questionstyle,
        frametitle={Question \thequestioncounter: \IfNoValueTF{#1}{\null}{#1}}
    ]
}{%
    \end{mdframed}
}

\NewDocumentEnvironment{bonusquestion}{o}{%
    \stepcounter{bonusquestioncounter}%
    \begin{mdframed}[
        style=questionstyle,
        frametitle={Bonus Question \thebonusquestioncounter: \IfNoValueTF{#1}{Default Title}{#1}}
    ]
}{%
    \end{mdframed}
}

% Extra environment
\NewDocumentEnvironment{extra}{o}{%
    \begin{mdframed}[
        style=extrastyle,
        frametitle=\IfNoValueTF{#1}{\null}{#1}
    ]
    \vspace{.5em}% add a bit of space to prevent bullets from riding up
}{%
    \end{mdframed}
}


% Important environment
\NewDocumentEnvironment{important}{o}{%
    \begin{mdframed}[
        style=importantstyle,
        frametitle=\IfNoValueTF{#1}{\null}{#1}
    ]
    \vspace{.5em}% add a bit of space to prevent bullets from riding up
}{%
    \end{mdframed}
}

%% 
% Aside environment
%%
% Define collections for left and right content
\definecollection{leftcontent}
\definecollection{rightcontent}

% Counter to make unique collection names
\newcounter{asidecounter}

% Define the sub-environments
\NewDocumentEnvironment{leftcontent}{+b}{%
    \begin{collect}{leftcontent\theasidecounter}{}{}%
    #1%
    \end{collect}%
}{}

\NewDocumentEnvironment{rightcontent}{+b}{%
    \begin{collect}{rightcontent\theasidecounter}{}{}%
    #1%
    \end{collect}%
}{}

% Define the main aside environment
\NewDocumentEnvironment{aside}{O{0.6,0.4}m}{%
    % Define new collections for this instance
    \stepcounter{asidecounter}%
    \definecollection{leftcontent\theasidecounter}%
    \definecollection{rightcontent\theasidecounter}%
    % Start the environment
    \par\noindent%
    \begin{paracol}{2}[\medskip]%
    \columnratio{#1}%
    \switchcolumn[0]%
    \includecollection{leftcontent\theasidecounter}%
    \switchcolumn[1]%
    \begin{mdframed}[style=extrastyle,frametitle={#2}]%
    \vspace{.5em}% add a bit of space to prevent bullets from riding up
    \includecollection{rightcontent\theasidecounter}%
    \end{mdframed}%
    \end{paracol}%
    \par%
}{}
%% 
% End Aside environment
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\lstset{style=defaultstyle, format=V, numbers=none}

