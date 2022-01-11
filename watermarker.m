function varargout = watermarker(varargin)
% watermarker MATLAB code for watermarker.fig
%      watermarker, by itself, creates a new watermarker or raises the existing
%      singleton*.
%
%      H = watermarker returns the handle to a new watermarker or the handle to
%      the existing singleton*.
%
%      watermarker('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in watermarker.M with the given input arguments.
%
%      watermarker('Property','Value',...) creates a new watermarker or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before watermarker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to watermarker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help watermarker

% Last Modified by GUIDE v2.5 09-Jan-2022 14:12:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @watermarker_OpeningFcn, ...
    'gui_OutputFcn',  @watermarker_OutputFcn, ...
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


% --- Executes just before watermarker is made visible.
function watermarker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to watermarker (see VARARGIN)

% Choose default command line output for watermarker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes watermarker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = watermarker_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg', 'Select a jpg image');
if ~ischar(filename); return; end      %user cancelled
filepath = fullfile(pathname, filename);
global img;
img = imread(filepath);
imshow(img);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.png', 'Select a png logo');
if ~ischar(filename); return; end      %user cancelled
filepath = fullfile(pathname, filename);
global logo;
logo = imread(filepath);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global y;
[x,y]=ginput(1);
X=x;
x=round(y);
y=round(X);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img; global logo; global extend;
global x; global y; global alpha;
[m,n,b] = size(logo);
X = x-m/2;
Y = y-n/2;
offset = [X Y]; % [y x]
mask = repmat(rgb2gray(logo)>5,[1 1 3]);
roirows = offset(1):offset(1)+size(logo,1)-1;
roicols = offset(2):offset(2)+size(logo,2)-1;
roi = img(roirows,roicols,:);
roi(mask) = alpha*logo(mask) + (1-alpha)*roi(mask);
out = img;
out(roirows,roicols,:) = roi;
imshow(out)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global e_level;
e_level=str2double(get(handles.edit2,'string'));
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img; global x; global y; global e_level; global emboss;

logo_e = emboss;
[q,w,r] = size(img);
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

extend = zeros(q,w);
[m,n] = size(logo_e);
extend((x-m/2):m+(x-m/2)-1, (y-n/2):n+(y-n/2)-1) = logo_e;
extend = im2uint8(extend);
img_r = img_r + extend*e_level;
img_g = img_g + extend*e_level;
img_b = img_b + extend*e_level;
final = cat(3, img_r, img_g, img_b);
imshow(final);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global logo; global img; global x; global y; global e; global emboss;
MaskSize = 5;
MyImage = logo;
paddsize = floor(MaskSize/2);
[a, b,z]=size(MyImage);
MyImage = double(padarray(MyImage,[paddsize paddsize]));
[c, d, f] = size(MyImage);
I2 = zeros(c,d);
for i=paddsize+1:c-paddsize
    for j=paddsize+1:d-paddsize
        pixbuffer = MyImage(i-paddsize:i+paddsize,j-paddsize:j+paddsize);
        maskY = ones(MaskSize,MaskSize)*1/(MaskSize*MaskSize);
        myTry = double(pixbuffer).*maskY;
        I2(i,j) = sum(sum(myTry));
    end
end
MyScaledImage = I2((paddsize+3):(c-paddsize),(paddsize+1):(d-paddsize));
MaskSize = 3;
paddsize = floor(MaskSize/2);
[a b]=size(MyScaledImage);
MyScaledImage = double(padarray(MyScaledImage,[paddsize paddsize]));
[c d] = size(MyScaledImage);
I3 = zeros(c,d);
for i=paddsize+1:c-paddsize
    for j=paddsize+1:d-paddsize
        pixbuffer = MyScaledImage(i-paddsize:i+paddsize,j-paddsize:j+paddsize);
        maskY = [-2 -1 0; -1 1 1; 0 1 2];
        myTry = double(pixbuffer).*maskY;
        I3(i,j) = sum(sum(myTry));
    end
end
emboss = I3((paddsize+3):(c-paddsize),(paddsize+1):(d-paddsize));



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global alpha;
alpha=str2double(get(handles.edit4,'string'));
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global width; global logo;
width=str2double(get(handles.edit5,'string'));
logo = imresize(logo,[width NaN]);
% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img; global logo; global extend;
global x; global y;

[q,w,e] = size(img);
[m,n,c] = size(logo);

extend = zeros(q,w,3);
extend = im2uint8(extend);
extend((x-m/2):m+(x-m/2)-1, (y-n/2):n+(y-n/2)-1, :) = logo;

for i=1:q
    for j=1:w
        for k=1:e
            if extend(i,j,k)==0
                extend(i,j,k)=img(i,j,k);
            end
        end
    end
end
imshow(extend);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myString = sprintf('First, choose a jpeg background image. Second, choose a transparent png logo. Then you can enter a width value. After clicking the "Choose Location" button and clicking somewhere random in the image, you are halfway there to apply watermark or embossment. After entering an Alpha Level between 0 and 1(0:No transparency, 1:Full transparency), you can click "Watermark" button. To apply a embossment, first click the "Create Embossment" button. Then choose a Brightness Level between 0 and 1 (0:Lowest Brightness 1:Full Brightness). Click "Apply Embossment" button. To exit the GUI, click the EXIT button below.');
set(handles.text7, 'String', myString);
set(handles.text7, 'Visible', "on");
drawnow; 

% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text7, 'String', '');
set(handles.text7, 'Visible', "off");
