function [n, x, c0] = init(var)

%% Startwerte für die Übung im Modul numerische Strömungsmechanik
% Robert Sämann, Hannover, den 11.05.2017

% n      : Gesamtzahl der Knoten
% x      : Knotenpositionen
% c0     : Anfangsbedingung

%% Anwendungsbeispiele

% Erzeuge Startwerte Rechteck und Gausspuls
% [n x c0] = init() 
% oder
% [n x c0] = init(1) 
%
% Nur Rechteck zum Vergleich mit der analytischen Lösung
% [n x c0] = init(2) 
%
% Andere Startwerte zum spielen
% [n x c0] = init(3) % Sinus
% [n x c0] = init(4) % Beispiel aus LeVeque

%% Fehlerüberprüfung
% Überprüfe die Anzahl der Eingabeargumente
% Wenn keine Eingabeargumente, nehme die ersten Anfangsbed.
if nargin == 0
    var = 1;
end %if

% Überprüfe, ob alle drei Ausgabeargumente eingelesen werden
if nargout ~= 3
    error('Die Funktion init() gibt drei Werte zurück. Bitte Beispiele beachten!')
end %if

%% Ausgabe festlegen
n = 201;                         %Anzahl der Knoten
x = linspace(0, 1, n)';       %Knotenpositionen

switch var
    case 1 % Rechteck und Gausskurve
        c0 = exp(-((x-5/20)*20).^2);             %Gausskurve
        c0((x <= 16/20) & (x >= 14/20)) = 1;   %Rechteck
        
    case 2 % Rechteck
        c0 = zeros(n,1);
        c0((x <= 0.75) & (x >= 0.25)) = 1;         
    
    case 3 % Sinuskurve
        c0 = sin(2*pi*x/(max(x+x(2)-x(1))));

    case 4 % Beispiel aus LeVeque
        % Leveque: "Numerical Methods for Conservation Laws",
        % Birkhäuser, 1992, p. 10
        dn = fix(n/8);
        
        c0 = [3*ones(2*dn, 1); linspace(3, 2, dn)'; ...
              2*ones(2*dn, 1); 1.5*ones(2*dn, 1); ...
              ones(n-7*dn, 1)];
    
    otherwise %Fehler, wenn es die Anfangsbedingung nicht gibt.
        error(['Die Anfangsbedingung ' num2str(var) ' ist nicht implementiert!']);
       
end %switch var
        


end %function




