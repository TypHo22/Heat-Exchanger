function varargout = Waermetauscher1(varargin)
% WAERMETAUSCHER1 MATLAB code for Waermetauscher1.fig
%      WAERMETAUSCHER1, by itself, creates a new WAERMETAUSCHER1 or raises the existing
%      singleton*.
%
%      H = WAERMETAUSCHER1 returns the handle to a new WAERMETAUSCHER1 or the handle to
%      the existing singleton*.
%
%      WAERMETAUSCHER1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAERMETAUSCHER1.M with the given input arguments.
%
%      WAERMETAUSCHER1('Property','Value',...) creates a new WAERMETAUSCHER1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Waermetauscher1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Waermetauscher1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Waermetauscher1

% Last Modified by GUIDE v2.5 26-Dec-2017 16:44:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Waermetauscher1_OpeningFcn, ...
                   'gui_OutputFcn',  @Waermetauscher1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Waermetauscher1 is made visible.
function Waermetauscher1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Waermetauscher1 (see VARARGIN)



% Choose default command line output for Waermetauscher1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Waermetauscher1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Waermetauscher1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Berechne.
function Berechne_Callback(hObject, eventdata, handles)
%%%%%%Abfrage der einzelnen Eingabefelder und umwandlung String in eine
%%%%%%Zahl und zuweisung in eine Variable
m_h=str2double(get(handles.m_h,'string'));
m_c=str2double(get(handles.m_c,'string'));
T_h=str2double(get(handles.T_h, 'string'));
T_c=str2double(get(handles.T_c, 'string'));
c_h=str2double(get(handles.c_h,'string'));
c_c=str2double(get(handles.c_c,'string'));
a_hw=str2double(get(handles.a_hw,'string'));
a_wc=str2double(get(handles.a_wc,'string'));
k=str2double(get(handles.k,'string'));
d=str2double(get(handles.d,'string'));
ml=str2double(get(handles.ml,'string'));
b=str2double(get(handles.b,'string'));
gs_state= get(handles.radiobutton_GS,'Value');
ggs_state= get(handles.radiobutton_GGS,'Value');



if (gs_state==1)
    cla;
    Wh=m_h*c_h;
    Wc=m_c*c_c;
    Hges= m_h*c_h*T_h+m_c*c_c*T_c; %Gesamt-Enthalpiestrom
    A=ml*b;
    R = 1/A*(1/a_hw + d/k + 1/a_wc); %Gesamter Wärmewiderstand
    C0 = (1/R)*((1/Wh) + (1/Wc));
    deltaT0= T_h-T_c; % Temperaturdifferenz zum Zeitpunkt x=0
    x=[0:0.1:ml]; % Länge des Wärmetauschers relevant für Plot und Berechnung der Temperaturabstände
    THx = (1/(Wh+Wc))*(Hges+Wc*deltaT0*exp(-C0*x));
    TCx = (1/(Wh+Wc))*(Hges-Wh*deltaT0*exp(-C0*x));
    
    plot(x,THx,'r->','LineWidth',2);
    hold on
    plot(x,TCx,'b->','LineWidth',2);
end

if (ggs_state==1 )
    cla;
    Wh=m_h*c_h;
    Wc=m_c*c_c;
    Hges= Wh*T_h-Wc*T_c; %Gesamt-Enthalpiestrom
    A=ml*b;
    R = 1/A*(1/a_hw + d/k + 1/a_wc); %Gesamter Wärmewiderstand
    C0 = (1/R)*((1/Wh) - (1/Wc));
    deltaT0= T_h-T_c; % Temperaturdifferenz bei x=0 zwischen Hot in und cold out
    x=[0:0.1:ml]; % Länge des Wärmetauschers relevant für Plot und Berechnung der Temperaturabstände
    THxggs = (1/(Wh-Wc))*(Hges-Wc*deltaT0*exp(-C0*x));
    TCxggs = (1/(Wh-Wc))*(Hges-Wh*deltaT0*exp(-C0*x));
    
  
    plot(x,THxggs,'r->','LineWidth',2);
    hold on
    plot(x,TCxggs,'b<-','LineWidth',2);
end





% --- Executes during object creation, after setting all properties.
%function m_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in radiobutton_Ja.
function radiobutton_Ja_Callback(hObject, eventdata, handles)
knowledge_state_ja= get(handles.radiobutton_Ja, 'Value');

if (knowledge_state_ja==1)
    set(handles.kin_vis_h,'Visible','off');
    set(handles.kin_vis_c,'Visible','off');
    set(handles.k_h,'Visible','off');
    set(handles.k_c,'Visible','off');
    set(handles.p_h,'Visible','off');
    set(handles.p_c,'Visible','off');
    set(handles.text27,'Visible','off');
    set(handles.text28,'Visible','off');
    set(handles.text29,'Visible','off');
    set(handles.text30,'Visible','off');
    set(handles.text31,'Visible','off');
    set(handles.text32,'Visible','off');
    set(handles.text33,'Visible','off');
    set(handles.text34,'Visible','off');
    set(handles.text35,'Visible','off');
    set(handles.text36,'Visible','off');
    set(handles.text37,'Visible','off');
    set(handles.text38,'Visible','off');
    set(handles.Waermeuebergang,'Visible','off');
end


% --- Executes on button press in radiobutton_Nein.
function radiobutton_Nein_Callback(hObject, eventdata, handles)
knowledge_state_nein= get(handles.radiobutton_Nein,'Value');
if (knowledge_state_nein==1)
     set(handles.kin_vis_h,'Visible','on');
    set(handles.kin_vis_c,'Visible','on');
    set(handles.k_h,'Visible','on');
    set(handles.k_c,'Visible','on');
    set(handles.p_h,'Visible','on');
    set(handles.p_c,'Visible','on');
    set(handles.text27,'Visible','on');
    set(handles.text28,'Visible','on');
    set(handles.text29,'Visible','on');
    set(handles.text30,'Visible','on');
    set(handles.text31,'Visible','on');
    set(handles.text32,'Visible','on');
    set(handles.text33,'Visible','on');
    set(handles.text34,'Visible','on');
    set(handles.text35,'Visible','on');
    set(handles.text36,'Visible','on');
    set(handles.text37,'Visible','on');
    set(handles.text38,'Visible','on');
    set(handles.Waermeuebergang,'Visible','on');
   
end



% --- Executes on button press in radiobutton_GS.
function radiobutton_GS_Callback(hObject, eventdata, handles)
gs_state= get(handles.radiobutton_GS,'Value');
if(gs_state==1)
     set(handles.text23,'String','Temperatur Hot IN');
     set(handles.text24,'String','Temperatur Cold IN');
      set(handles.h_out,'Visible','off');
     set(handles.c_out,'Visible','off');
     set(handles.text41,'Visible','off');
     set(handles.text42,'Visible','off');
     set(handles.text43,'Visible','off');
     set(handles.text44,'Visible','off');
end

% --- Executes on button press in radiobutton_GGS.
function radiobutton_GGS_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_GGS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ggs_state= get(handles.radiobutton_GGS,'Value');
if(ggs_state==1)
     set(handles.text23,'String','Temperatur Hot IN');
   
     set(handles.text24,'String','Temperatur Cold OUT');
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_GGS

% --- Executes on button press in Waermeuebergang.
function Waermeuebergang_Callback(hObject, eventdata, handles)
m_h=str2double(get(handles.m_h,'string'));
m_c=str2double(get(handles.m_c,'string'));
c_h=str2double(get(handles.c_h,'string'));
c_c=str2double(get(handles.c_c,'string'));
kinvish=str2double(get(handles.kin_vis_h,'string'));
kinvisc=str2double(get(handles.kin_vis_h,'string'));
kh=str2double(get(handles.k_h,'string'));
kc=str2double(get(handles.k_c,'string'));
ph=str2double(get(handles.p_h,'string'));
pc=str2double(get(handles.p_c,'string'));   
ml=str2double(get(handles.ml,'string'));

vh= m_h/ph; %% Umrechnung Massenstrom in eine Strömungsgeschwindigkeit
vc= m_c/pc; %% Umrechnung Massenstrom in eine Strömungsgeschwindigkeit
Re_h= (vh*ml)/kinvish; %% Berechnung Reynoldszahl
Re_c= (vc*ml)/kinvisc; %% Berechnung Reynoldszahl
Pr_h=(kinvish*c_h)/kh; %% Berechnung Prandlzahl
Pr_c=(kinvisc*c_c)/kc; %% Berechnung Prandlzahl
Num_h= (0.037*(Re_h^0.8) *Pr_h)/(142.443*(Re_h^(-0.1))*(Pr_h^(2/3)-1)); %% Berechnung Nußeltzahl
Num_c= (0.037*(Re_c^0.8) *Pr_c)/(142.443*(Re_c^(-0.1))*(Pr_c^(2/3)-1)); %% Berechnung Nußeltzahl
a_hot= (Num_h*kh)/ml; %% Berechnung Waermeuebergang hot
a_cold= (Num_c*kc)/ml; %% Berechnung Waermeuebergang cold

set(handles.a_hw,'String',a_hot); % schreibe in Feld für Wärmeübergang
set(handles.a_wc,'String',a_cold); % schreibe in Feld für Wärmeübergang


% --- Executes on button press in infobtn.
function infobtn_Callback(hObject, eventdata, handles)
msgbox([{'This GUI is used to calculate heat exchangers in countercurrent and DC operation. Important for the heat transfer is the convective heat transfer on both sides. This depends essentially on the geometry of the surface and the degree of turbulence of the flowing medium. If the convective heat transfer is not known, it can also be determined. However, the formula stored here should be used with a certain "caution", as it does not take into account the surface quality of the transferring surface. The literature according to Prof. Dr. rer. nat. M. Pfitzner "Fundamentals of Heat Transfer" following values:'},{'Gases free convection: 2-25'},{'Gases forced convection: 25-250'},{'Liquid free convection: 50-1000'},{'Liquid forced convection: 50-20000'},{''},{'This GUI was programmed by Andreas Bernatzky within the AFE Master Project I at Rosenheim University in WS 17/18'},{'26.12.2017'}]);
% hObject handle to infobtn (see GCBO)


% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
