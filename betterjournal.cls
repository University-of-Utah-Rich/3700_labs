\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{betterjournal}[2024/10/24 Custom article class]

% Load the base article class with any options passed to your class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{journal}}
\ProcessOptions\relax
\LoadClass[10pt]{article}

\usepackage[scaled=1.0]{helvet}
\renewcommand{\familydefault}{\sfdefault}

\usepackage[letterspace=500]{microtype}

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
