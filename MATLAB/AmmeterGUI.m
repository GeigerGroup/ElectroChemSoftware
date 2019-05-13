function varargout = AmmeterGUI(varargin)
% AMMETERGUI MATLAB code for AmmeterGUI.fig
%      AMMETERGUI, by itself, creates a new AMMETERGUI or raises the existing
%      singleton*.
%
%      H = AMMETERGUI returns the handle to a new AMMETERGUI or the handle to
%      the existing singleton*.
%
%      AMMETERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AMMETERGUI.M with the given input arguments.
%
%      AMMETERGUI('Property','Value',...) creates a new AMMETERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AmmeterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AmmeterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AmmeterGUI

% Last Modified by GUIDE v2.5 26-Oct-2018 12:46:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AmmeterGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AmmeterGUI_OutputFcn, ...
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


% --- Executes just before AmmeterGUI is made visible.
function AmmeterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AmmeterGUI (see VARARGIN)

% Choose default command line output for AmmeterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%popup for range
rangeStrings = {'Auto','2nA','20nA','200nA','2uA','20uA','200uA','2mA','20mA'};
handles.rangePopup.String = rangeStrings;
handles.rangePopup.Value = 1; %set default value here

%popup for rate
rateStrings = {'SLOW','MED','FAST'};
handles.ratePopup.String = rateStrings;
handles.ratePopup.Value = 2; %set default value here


% --- Outputs from this function are returned to the command line.
function varargout = AmmeterGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in buttonConnect.
function buttonConnect_Callback(~,~,~)
a = Ammeter();
setappdata(0,'Ammeter',a);

% --- Executes on button press in disconnectButton.
function disconnectButton_Callback(~,~,~)
a = getappdata(0,'Ammeter');
a.close()

% --- Executes on button press in changeConnectionsButton.
function changeConnectionsButton_Callback(~,~,~)
a = getappdata(0,'Ammeter');
a.setZeroCheck(true)

% --- Executes on button press in enableMeasurementButton.
function enableMeasurementButton_Callback(~,~,~)
a = getappdata(0,'Ammeter');
a.setZeroCheck(false)

% --- Executes on selection change in rangePopup.
function rangePopup_Callback(hObject, ~, ~)
% hObject    handle to rangePopup (see GCBO)
%strings to send based on popup menu
strings = {':AUTO 1', ' 2E-9',' 2E-8',' 2E-7',' 2E-6',' 2E-5',' 2E-4',' 2E-3',' 2E-2'};
a = getappdata(0,'Ammeter'); %get ammeter
a.setRange(strings{hObject.Value}); %send range

% --- Executes on selection change in ratePopup.
function ratePopup_Callback(hObject,~,~)
% hObject    handle to ratePopup (see GCBO)
rates = [6 1 0.1];
a = getappdata(0,'Ammeter'); %get ammeter
a.setRate(rates(hObject.Value)); %set rate

% --- Executes on button press in startMeasurementButton.
function startMeasurementButton_Callback(~,~, handles)
% handles    structure with handles and user data (see GUIDATA)
time = [0.5 0.1 0.05];
a = getappdata(0,'Ammeter'); %get ammeter
m = Measurement(handles.nameEdit.String,a,time(handles.ratePopup.Value));
m.startMeasurement;
%setappdata(0,handles.nameEdit.String,m)