
function varargout = spam_detection(varargin)
% SPAM_DETECTION MATLAB code for spam_detection.fig
%      SPAM_DETECTION, by itself, creates a new SPAM_DETECTION or raises the existing
%      singleton*.
%
%      H = SPAM_DETECTION returns the handle to a new SPAM_DETECTION or the handle to
%      the existing singleton*.
%
%      SPAM_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPAM_DETECTION.M with the given input arguments.
%
%      SPAM_DETECTION('Property','Value',...) creates a new SPAM_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spam_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spam_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spam_detection

% Last Modified by GUIDE v2.5 23-Sep-2014 08:37:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spam_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @spam_detection_OutputFcn, ...
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


% --- Executes just before spam_detection is made visible.
function spam_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spam_detection (see VARARGIN)

% Choose default command line output for spam_detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spam_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spam_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function email_Callback(hObject, eventdata, handles)
% hObject    handle to email (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of email as text
%        str2double(get(hObject,'String')) returns contents of email as a double


% --- Executes during object creation, after setting all properties.
function email_CreateFcn(hObject, eventdata, handles)
% hObject    handle to email (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prepare.
function prepare_Callback(hObject, eventdata, handles)
% hObject    handle to prepare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.email,'String');
[editedEmail,wordsArray]=processEmail(a);
set(handles.editedEmail,'String',editedEmail); 
x   = emailFeatures(wordsArray);
handles.x=x;
guidata(hObject,handles);


% --- Executes on button press in train.
function train_Callback(hObject, eventdata, handles)
% hObject    handle to train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load the Spam Email dataset
% You will have X, y in your environment
load('spamTrain.mat');
%  This function will return theta and the cost 
[m, n] = size(X);
C = 0.1;
model = svmTrain(X, y, C, @linearKernel);

handles.model=model;
guidata(hObject,handles);



% --- Executes on button press in spam.
function spam_Callback(hObject, eventdata, handles)
% hObject    handle to spam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p = svmPredict(handles.model, handles.x);
fprintf('classification: %f\n',p);

if(p==1)
   set(handles.result,'String','no spam');
else
    set(handles.result,'String','spam');
end;
