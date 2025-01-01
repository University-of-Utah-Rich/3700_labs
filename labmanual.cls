\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{labmanual}[2024/10/24 Custom article class]

% Load the base article class with any options passed to your class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{journal}}
\ProcessOptions\relax
\LoadClass[10pt]{article}

\usepackage[scaled=1.0]{helvet}
\renewcommand{\familydefault}{\sfdefault}

\usepackage[letterspace=500]{microtype}
\usepackage[scaled=0.85]{beramono}
% Your resets and modifications go here
 \usepackage{parskip}


\hyphenpenalty=5000  % Makes hyphenation very unlikely
\exhyphenpenalty=10000  % Makes hyphenation of already-hyphenated words very unlikely


% Save original list parameters
\let\olditemize\itemize
\let\endolditemize\enditemize
\let\oldenumerate\enumerate
\let\endoldenumerate\endenumerate

% Remove indent and add spacing between paragraphs
\setlength{\parindent}{0pt}
\setlength{\parskip}{1\baselineskip}

% Restore original list spacing inside itemize
\renewenvironment{itemize}{%
    \setlength{\parskip}{1em}% Reset parskip inside lists
    \olditemize
}{%
    \endolditemize
    \setlength{\parskip}{1\baselineskip}% Restore parskip after list
}

% Restore original list spacing inside enumerate
\renewenvironment{enumerate}{%
    \setlength{\parskip}{1em}% Reset parskip inside lists
    \oldenumerate
}{%
    \endoldenumerate
    \setlength{\parskip}{1\baselineskip}% Restore parskip after list
}

% Alter some LaTeX defaults for better treatment of figures:
    % See p.105 of "TeX Unbound" for suggested values.
    % See pp. 199-200 of Lamport's "LaTeX" book for details.
    %   General parameters, for ALL pages:
    \renewcommand{\topfraction}{0.9}	% max fraction of floats at top
    \renewcommand{\bottomfraction}{0.8}	% max fraction of floats at bottom
    %   Parameters for TEXT pages (not float pages):
    \setcounter{topnumber}{2}
    \setcounter{bottomnumber}{2}
    \setcounter{totalnumber}{4}     % 2 may work better
    \setcounter{dbltopnumber}{2}    % for 2-column pages
    \renewcommand{\dbltopfraction}{0.9}	% fit big float above 2-col. text
    \renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
    %   Parameters for FLOAT pages (not text pages):
    \renewcommand{\floatpagefraction}{0.7}	% require fuller float pages
	% N.B.: floatpagefraction MUST be less than topfraction !!
    \renewcommand{\dblfloatpagefraction}{0.7}	% require fuller float pages

	% remember to use [htp] or [htpb] for placement

    \usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage[version=4]{mhchem}
\usepackage{stmaryrd}
\usepackage{graphicx}
\usepackage[export]{adjustbox}
\usepackage{fancyhdr}
\usepackage{verbatim}
\usepackage[formats]{listings}
\usepackage{xcolor}
\usepackage{float}
\usepackage{newfloat}
\usepackage{array}
\usepackage{fancyvrb}
\usepackage{makecell}
\usepackage{multicol}
\usepackage{bold-extra} % Provides bold support for monospaced fonts
\usepackage{chngpage}
\usepackage{geometry}
\usepackage{paracol}
\usepackage{fancyhdr}
\usepackage{longtable}
\usepackage{caption} % For table numbering
\usepackage{soul}
\usepackage{varioref}
\usepackage{wrapfig}
\usepackage{hyperref}
\usepackage{subcaption}
\usepackage{booktabs}
\usepackage[framemethod=TikZ]{mdframed}
% Define the new aside environment style without arrows
\usepackage{xparse}
\usepackage{xstring}
\usepackage{tikz}
% Load required packages
\usepackage[most]{tcolorbox}
\usepackage{enumitem}
\usepackage{flafter}
\usepackage{environ}

\mdfsetup{skipabove=1em,skipbelow=1em}

% Create a wrapper for non-breaking environments
\newcommand{\makeunbreakable}[1]{%
  \expandafter\RenewEnviron\expandafter{#1}{%
    \par\nobreak\vfil\penalty0\vfilneg
    \begin{samepage}
      \BODY
    \end{samepage}
  }%
}


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

\newcommand{\code}[1]{\textbf{\texttt{#1}}}

%\newcommand{\keyword}[1]{\textbf{\texttt{#1}}}

\usetikzlibrary{shapes,arrows,positioning,calc,shadows.blur}
% Reduce left and right margins
\geometry{
  left=2cm,  % Adjust the left margin
  right=2cm, % Adjust the right margin (leaving space for the right column)
  top=2.5cm,
  bottom=2.5cm
}

\definecolor{black}{rgb}{0,0,0}
\definecolor{yellow}{rgb}{1, 0.89, 0.36}
\definecolor{blue}{rgb}{0.49803922, 0.78431373, 0.97254902}
\newcommand{\keyword}[1]{{\usefont{OT1}{lmtt}{b}{n}#1}}


\newcommand{\todo}[1]{\hl{\textbf{TODO: #1}}}

% Define a counter for the question environment
\newcounter{questioncounter}

% Define a custom environment that wraps around mdframed and accepts a custom title argument
\NewDocumentEnvironment{question}{o}{ % [o] denotes an optional argument
  \stepcounter{questioncounter} % Increment the counter
  \begin{mdframed}[
    backgroundcolor=yellow!40,
    roundcorner=10pt,
    linewidth=1pt,
    linecolor=black, % Set border color to black
    frametitlebackgroundcolor=yellow!50, % Match background color for title
    frametitleaboveskip=10pt,
    frametitlebelowskip=5pt,
    frametitlerule=false, % remove black border under the title
    frametitlerulecolor=black, % Set title border color to black
    nobreak=true,
    frametitle={Question \thequestioncounter: \IfNoValueTF{#1}{Default Title}{#1}} % If no title, use "Default Title"
  ]
}{
\end{mdframed}
}

\newcounter{bonusquestioncounter}
\NewDocumentEnvironment{bonusquestion}{o}{ % [o] denotes an optional argument
  \stepcounter{bonusquestioncounter} % increment the counter for bonusquestion
  \begin{mdframed}[
    backgroundcolor=yellow!40,
    roundcorner=10pt,
    linewidth=1pt,
    linecolor=black, % Set border color to black
    frametitlebackgroundcolor=yellow!50, % Match background color for title
    frametitleaboveskip=10pt,
    frametitlebelowskip=5pt,
    frametitlerule=false, % Ensure a black border under the title
    frametitlerulecolor=black, % Set title border color to black
    nobreak=true,
    frametitle={Bonus Question \thebonusquestioncounter: \IfNoValueTF{#1}{Default Title}{#1}} % If no title, use "Default Title"
  ]
}{
\end{mdframed}
}

\NewDocumentEnvironment{aside}{O{0.7,0.3}O{right}O{}}{%
  \par\noindent%
  \columnratio{#1}%
  \begin{paracol}{2}%
  \IfStrEqCase{#2}{%
    {left}{\switchcolumn[0]}%
    {right}{\switchcolumn[1]}%
  }
  \begin{extra}[frametitle=#3]%
}{%
  \end{extra}%
  \IfStrEqCase{#2}{%
    {left}{\switchcolumn[1]}%
    {right}{\switchcolumn[0]}%
  }
  \end{paracol}%
  \par%
}

\newmdenv[
  backgroundcolor=blue!50,
  roundcorner=10pt,
  linewidth=1pt,
  linecolor=black, % Set border color to black
  frametitlebackgroundcolor=blue!60, % Match background color for title
  frametitleaboveskip=10pt,
  frametitlebelowskip=5pt,
  frametitlerule=false, % Ensure a black border under the title
  frametitlerulecolor=blue,
  nobreak=true
]{extra}

\newmdenv[
  backgroundcolor=red!50,
  roundcorner=10pt,
  linewidth=1pt,
  linecolor=black, % Set border color to black
  frametitlebackgroundcolor=red!60, % Match background color for title
  frametitleaboveskip=10pt,
  frametitlebelowskip=5pt,
  frametitlerule=false, % Ensure a black border under the title
  frametitlerulecolor=red, % Set title border color to black
  nobreak=true
]{important}


\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

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

\lstdefinestyle{mystyle}{
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

\lstset{style=mystyle, format=V, numbers=none}

