function varargout = AppEditingPhoto(varargin)
% APPEDITINGPHOTO MATLAB code for AppEditingPhoto.fig
%      APPEDITINGPHOTO, by itself, creates a new APPEDITINGPHOTO or raises the existing
%      singleton*.
%
%      H = APPEDITINGPHOTO returns the handle to a new APPEDITINGPHOTO or the handle to
%      the existing singleton*.
%
%      APPEDITINGPHOTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPEDITINGPHOTO.M with the given input arguments.
%
%      APPEDITINGPHOTO('Property','Value',...) creates a new APPEDITINGPHOTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AppEditingPhoto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AppEditingPhoto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AppEditingPhoto

% Last Modified by GUIDE v2.5 13-Nov-2024 23:15:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AppEditingPhoto_OpeningFcn, ...
                   'gui_OutputFcn',  @AppEditingPhoto_OutputFcn, ...
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


% --- Executes just before AppEditingPhoto is made visible.
function AppEditingPhoto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AppEditingPhoto (see VARARGIN)

% Choose default command line output for AppEditingPhoto
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AppEditingPhoto wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AppEditingPhoto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectimage.
function selectimage_Callback(hObject, eventdata, handles)
% hObject    handle to selectimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Memilih file gambar
[filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.tif'}, 'Select an Image');

    try
        Img = imread(fullfile(pathname, filename));

        % Memastikan gambar yang dipilih adalah RGB
        if size(Img, 3) == 3
            handles.Img = Img;  % Menyimpan gambar asli ke dalam handles.img
            handles.processedImg = Img; % Gambar yang diproses, mulai dengan gambar asli

            % Menampilkan gambar pada axes1
            axes(handles.axes1);
            imshow(Img);

            % Menampilkan histogram RGB di axes3
            axes(handles.axes3);
            cla;

            % Menghitung histogram untuk masing-masing kanal R, G, dan B
            R = Img(:,:,1); % Kanal merah
            G = Img(:,:,2); % Kanal hijau
            B = Img(:,:,3); % Kanal biru

            % Menampilkan histogram masing-masing kanal
            hold on;
            histogram(R(:), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.3);
            histogram(G(:), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.3);
            histogram(B(:), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.3);
            hold off;

            % Menambahkan judul dan label untuk histogram
            xlabel('Intensity');
            ylabel('Frequency');
            title('RGB Histogram');

            % Update handles structure
            guidata(hObject, handles);
        else
            msgbox('Please input an RGB image');
        end
    catch
        msgbox('Failed to load image');

end

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.processedImg = handles.Img; % Reset ke gambar asli
axes(handles.axes1); % Tampilkan di sumbu gambar yang diproses
imshow(handles.processedImg);
cla(handles.axes1); % Bersihkan histogram sumbu
cla(handles.axes2); % Bersihkan histogram sumbu
cla(handles.axes3); % Bersihkan histogram sumbu
cla(handles.axes4); % Bersihkan histogram sumbu
guidata(hObject, handles);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'processedImg')  % Cek apakah ada gambar yang telah diproses
    [filename, pathname] = uiputfile({'*.jpg';'*.png';'*.bmp'}, 'Save Image As');
    if filename
        % Menyimpan gambar yang telah diproses
        imwrite(handles.processedImg, fullfile(pathname, filename));
        msgbox('Image saved successfully.');
    end
else
    msgbox('No processed image to save', 'Error', 'error');
end


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Img')
    Img = handles.Img;  % Mengambil gambar dari handles

    % Mengekstrak kanal merah
    redImg = Img;  % Salin gambar
    redImg(:,:,2) = 0;  % Set kanal hijau menjadi 0
    redImg(:,:,3) = 0;  % Set kanal biru menjadi 0

    % Menampilkan gambar kanal merah di axes2
    axes(handles.axes2);
    imshow(redImg);
    
    % Menampilkan histogram gambar kanal merah di axes4
    axes(handles.axes4);
    [counts, binLocations] = imhist(redImg(:,:,1));  % Mengambil data histogram kanal merah
    bar(binLocations, counts, 'FaceColor', 'r');  % Membuat histogram dengan warna merah

    % Menyimpan gambar kanal merah ke dalam handles
    handles.processedImg = redImg;
    guidata(hObject, handles);
else
    msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
end

% --- Executes on button press in greyscale.
function greyscale_Callback(hObject, eventdata, handles)
% hObject    handle to greyscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if isfield(handles, 'Img')
        Img = handles.Img;  % Mengambil gambar asli dari handles
        
        % Mengubah gambar menjadi skala abu-abu
        greyImg = rgb2gray(Img);
        
        % Menampilkan gambar skala abu-abu di axes2
        axes(handles.axes2);
        imshow(greyImg);
        
        % Menampilkan histogram skala abu-abu di axes4
        axes(handles.axes4);
        imhist(greyImg);
        
        % Menyimpan gambar ke dalam handles
        handles.processedImg = greyImg;  % Menyimpan gambar yang telah diproses
        guidata(hObject, handles);  % Memperbarui handles
    else
        msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
    end


% --- Executes on button press in blue.
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Img')
    Img = handles.Img;  % Mengambil gambar dari handles

    % Mengekstrak kanal biru
    blueImg = Img;  % Salin gambar
    blueImg(:,:,1) = 0;  % Set kanal merah menjadi 0
    blueImg(:,:,2) = 0;  % Set kanal hijau menjadi 0

    % Menampilkan gambar kanal biru di axes2
    axes(handles.axes2);
    imshow(blueImg);
    
    % Menampilkan histogram gambar kanal biru di axes4
    axes(handles.axes4);
    [counts, binLocations] = imhist(blueImg(:,:,3));  % Mengambil data histogram kanal biru
    bar(binLocations, counts, 'FaceColor', 'b');  % Membuat histogram dengan warna biru
    
    % Menyimpan gambar kanal biru ke dalam handles
    handles.processedImg = blueImg;
    guidata(hObject, handles);
else
    msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
end

% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Img')
    Img = handles.Img;  % Mengambil gambar dari handles

    % Mengekstrak kanal hijau
    greenImg = Img;  % Salin gambar
    greenImg(:,:,1) = 0;  % Set kanal merah menjadi 0
    greenImg(:,:,3) = 0;  % Set kanal biru menjadi 0

    % Menampilkan gambar kanal hijau di axes2
    axes(handles.axes2);
    imshow(greenImg);
    
    % Menampilkan histogram gambar kanal hijau di axes4
    axes(handles.axes4);
    [counts, binLocations] = imhist(greenImg(:,:,2));  % Mengambil data histogram kanal hijau
    bar(binLocations, counts, 'FaceColor', 'g');  % Membuat histogram dengan warna hijau

    % Menyimpan gambar kanal hijau ke dalam handles
    handles.processedImg = greenImg;
    guidata(hObject, handles);
else
    msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
end

% --- Executes on slider movement.
function blur_Callback(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
blurValue = get(hObject, 'Value');
set(handles.edit1, 'String', num2str(blurValue));

% Mengambil gambar dari handles, memprioritaskan processedImg jika ada
if isfield(handles, 'processedImg')
    Img = handles.processedImg;
elseif isfield(handles, 'Img')
    Img = handles.Img;
else
    disp('Tidak ada gambar untuk diproses.');
    return;
end

% Jika gambar biner (hanya memiliki nilai 0 dan 1), konversi ke grayscale
if islogical(Img)
    Img = uint8(Img) * 255; % Konversi dari biner ke grayscale (0 dan 255)
end

% Mengatur nilai blur; jika 0, tidak ada perubahan
if blurValue == 0
    processedImg = Img;
else
    processedImg = imgaussfilt(Img, blurValue / 10);
end 

% Menampilkan gambar yang diproses di axes2
axes(handles.axes2);
imshow(processedImg);

% Mengatur tampilan histogram berdasarkan jumlah channel gambar
axes(handles.axes4);
if size(processedImg, 3) == 3  % Jika gambar berwarna
    redChannel = processedImg(:,:,1);
    greenChannel = processedImg(:,:,2);
    blueChannel = processedImg(:,:,3);
    
    % Plot histogram RGB
    [countsRed, binLocations] = imhist(redChannel, 256);
    countsGreen = imhist(greenChannel, 256);
    countsBlue = imhist(blueChannel, 256);
    
    plot(binLocations, countsRed, 'r', 'LineWidth', 1.5); hold on;
    plot(binLocations, countsGreen, 'g', 'LineWidth', 1.5);
    plot(binLocations, countsBlue, 'b', 'LineWidth', 1.5); hold off;
    xlim([0 255]);
else
    % Plot histogram untuk gambar greyscale atau hasil equalization/biner
    imhist(processedImg);
end

% Simpan gambar yang telah diproses untuk digunakan di fitur lain
handles.adjustedImage = processedImg;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function blur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject, 'Min', 0);
set(hObject, 'Max', 255);
set(hObject,'Value',0);


% --- Executes on slider movement.
function sharpness_Callback(hObject, eventdata, handles)
% hObject    handle to sharpness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sharpValue = get(hObject, 'Value');
set(handles.edit2, 'String', num2str(sharpValue));

   if isfield(handles, 'processedImg')
        Img = handles.processedImg;
    elseif isfield(handles, 'Img')
        Img = handles.Img;
    else
        disp('Tidak ada gambar untuk diproses.');
        return;
   end
  
    % Perluasan rentang jika gambar biner
    if islogical(Img)
        Img = uint8(Img) * 255; % Konversi dari biner ke grayscale
    end
    
    if sharpValue == 0
       processedImg = Img;
    else
        amount = sharpValue / 10; % Scaling for finer control
        radius = 1; % Set fixed radius for edge details
        threshold = 0; % Apply sharpening to all edges
        processedImg = imsharpen(Img, 'Amount', amount, 'Radius', radius, 'Threshold', threshold);
    end
    
    % Konversi kembali ke biner jika gambar awal adalah biner
    if islogical(handles.Img)
        processedImg = imbinarize(processedImg, 0.5); % Threshold 0.5 atau sesuai kebutuhan
    end

    
    axes(handles.axes2);
    imshow(processedImg); 
    
    % Mengatur tampilan histogram berdasarkan jumlah channel gambar
    axes(handles.axes4);

    if size(processedImg, 3) == 3
        redChannel = processedImg(:,:,1);
        greenChannel = processedImg(:,:,2);
        blueChannel = processedImg(:,:,3);
        
        axes(handles.axes4);
        [countsRed, binLocations] = imhist(redChannel, 256);
        countsGreen = imhist(greenChannel, 256);
        countsBlue = imhist(blueChannel, 256);
        
        plot(binLocations, countsRed, 'r', 'LineWidth', 1.5); hold on;
        plot(binLocations, countsGreen, 'g', 'LineWidth', 1.5);
        plot(binLocations, countsBlue, 'b', 'LineWidth', 1.5); hold off;
        xlim([0 255]);
    else
        imhist(processedImg);
    end
    
    handles.AdjustImage = processedImg;
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sharpness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject, 'Min', 0);
set(hObject, 'Max', 100);
set(hObject, 'Value', 0);


% --- Executes on slider movement.
function brightness_Callback(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
brightValue = get(hObject, 'Value');
set(handles.edit3, 'String', num2str(brightValue));

    if isfield(handles, 'processedImg')
        Img = handles.processedImg;
    elseif isfield(handles, 'Img')
        Img = handles.Img;
    else
        disp('Tidak ada gambar untuk diproses.');
        return;
    end
    
    if islogical(Img)
        Img = uint8(Img) * 255; % Konversi dari biner ke grayscale
    end
    
if (brightValue < 0)
        processedImg = Img - (brightValue * -1 );
    else
        processedImg = Img + (brightValue * 1);
end
    
    processedImg(processedImg > 255) = 255;
    processedImg(processedImg < 0) = 0;
    
    axes(handles.axes2);
    imshow(processedImg);   
    % Mengatur tampilan histogram berdasarkan jumlah channel gambar
    axes(handles.axes4);
    
    if size(processedImg, 3) == 3
        redChannel = processedImg(:,:,1);
        greenChannel = processedImg(:,:,2);
        blueChannel = processedImg(:,:,3);
        
        axes(handles.axes4);
        [countsRed, binLocations] = imhist(redChannel, 256);
        countsGreen = imhist(greenChannel, 256);
        countsBlue = imhist(blueChannel, 256);
        
        plot(binLocations, countsRed, 'r', 'LineWidth', 1.5); hold on;
        plot(binLocations, countsGreen, 'g', 'LineWidth', 1.5);
        plot(binLocations, countsBlue, 'b', 'LineWidth', 1.5); hold off;
        xlim([0 255]);
    else
        imhist(processedImg);
    end
    
    handles.AdjustImage = processedImg;
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject, 'Min', -50);
set(hObject, 'Max', 50);
set(hObject, 'Value', 0);


% --- Executes during object creation, after setting all properties.
function noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject, 'Min', 0);
set(hObject, 'Max', 50);
set(hObject, 'Value', 0);

% --- Executes on button press in equalization.
function equalization_Callback(hObject, eventdata, handles)
% hObject    handle to equalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Img')
    Img = handles.Img;  % Mengambil gambar dari handles

    % Jika gambar masih RGB, ubah ke grayscale terlebih dahulu
    if size(Img, 3) == 3
        Img = rgb2gray(Img);
    end

    % Equalisasi histogram
    equalizedImg = histeq(Img);

    % Menampilkan gambar yang telah diequalisasi di axes2
    axes(handles.axes2);
    imshow(equalizedImg);
    
    % Menampilkan histogram gambar yang telah diequalisasi di axes4
    axes(handles.axes4);
    imhist(equalizedImg);

    % Menyimpan gambar yang telah diequalisasi ke dalam handles
    handles.processedImg = equalizedImg;
    guidata(hObject, handles);
else
    msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
end

% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
noiseValue = get(hObject, 'Value');
set(handles.edit4, 'String', num2str(noiseValue));

   if isfield(handles, 'processedImg')
        Img = handles.processedImg;
    elseif isfield(handles, 'Img')
        Img = handles.Img;
    else
        disp('Tidak ada gambar untuk diproses.');
        return;
   end
    
   if islogical(Img)
        Img = uint8(Img) * 255; % Konversi dari biner ke grayscale
    end
    
if noiseValue == 0
            processedImg = Img;
        else
            % Pastikan noiseValue positif
            noiseAmount = abs(noiseValue) / 100;  % Gunakan nilai mutlak noiseValue
            processedImg = imnoise(Img, 'gaussian', noiseAmount / 10);
end

    axes(handles.axes2);
    imshow(processedImg);  
    
    
    % Mengatur tampilan histogram berdasarkan jumlah channel gambar
    axes(handles.axes4);
    
    if size(processedImg, 3) == 3
        redChannel = processedImg(:,:,1);
        greenChannel = processedImg(:,:,2);
        blueChannel = processedImg(:,:,3);
        
        axes(handles.axes4);
        [countsRed, binLocations] = imhist(redChannel, 256);
        countsGreen = imhist(greenChannel, 256);
        countsBlue = imhist(blueChannel, 256);
        
        plot(binLocations, countsRed, 'r', 'LineWidth', 1.5); hold on;
        plot(binLocations, countsGreen, 'g', 'LineWidth', 1.5);
        plot(binLocations, countsBlue, 'b', 'LineWidth', 1.5); hold off;
        xlim([0 255]);
    else
        imhist(processedImg);
    end
    
    handles.AdjustImage = processedImg;
    guidata(hObject, handles);

% --- Executes on button press in biner.
function biner_Callback(hObject, eventdata, handles)
% hObject    handle to biner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'processedImg')
        Img = handles.Img;  % Ambil gambar yang telah diproses
        
        % Jika gambar masih RGB, ubah ke grayscale
        if size(Img, 3) == 3
            Img = rgb2gray(Img);
        end
        
        % Tentukan ambang batas untuk binarisasi (gunakan ambang tetap atau slider)
        threshold_value = 128;  % Ambang batas untuk konversi
        
        % Terapkan binarisasi dengan threshold yang lebih tajam
        binaryImg = Img > threshold_value;  % Menghasilkan gambar biner yang jelas
        
        % Tampilkan gambar biner di axes2
        axes(handles.axes2);
        imshow(binaryImg);  % Menampilkan gambar hasil biner
        
        % Tampilkan histogram gambar biner pada axes4
        axes(handles.axes4);
        imhist(binaryImg);  % Histogram gambar biner
        
        % Simpan gambar biner ke dalam handles
        handles.processedImg = binaryImg;
        guidata(hObject, handles);
    else
        msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
    end

% --- Executes on button press in negative.
function negative_Callback(hObject, eventdata, handles)
% hObject    handle to negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Img')
    Img = handles.Img;  % Mengambil gambar dari handles

    % Menghitung gambar negatif
    negativeImg = 255 - Img;  % Inversi gambar

    % Menampilkan gambar negatif di axes2
    axes(handles.axes2);
    imshow(negativeImg);
    
    % Menampilkan histogram gambar negatif di axes4
    axes(handles.axes4);
    cla; % Membersihkan histogram sebelumnya
    if size(negativeImg, 3) == 3
            % Jika gambar berwarna, tampilkan histogram RGB
            R = negativeImg(:,:,1);
            G = negativeImg(:,:,2);
            B = negativeImg(:,:,3);
            hold on;
            histogram(R(:), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.3);
            histogram(G(:), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.3);
            histogram(B(:), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.3);
            hold off;
    end
    % Menyimpan gambar negatif ke dalam handles
    handles.processedImg = negativeImg;
    guidata(hObject, handles);
else
    msgbox('Pilih gambar terlebih dahulu!', 'Error', 'error');
end

% --------------------------------------------------------------------
function uipanel6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text12.
function text12_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in edgedetection.
function edgedetection_Callback(hObject, eventdata, handles)
% hObject    handle to edgedetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% method = questdlg('Select Edge Detection Method:', 'Edge Detection','Prewitt', 'Sobel', 'Canny');
% Cek apakah gambar telah dipilih
if isfield(handles, 'Img')
    % Mengambil metode yang dipilih di popupmenu1
    methods = cellstr(get(handles.popupmenu1, 'String'));
    selectedEdge = methods{get(handles.popupmenu1, 'Value')};

    % Konversi gambar asli ke grayscale (reset setiap kali metode berubah)
    grayImg = rgb2gray(handles.Img);  % Gunakan gambar asli di handles.Img
    
    % Terapkan metode deteksi tepi berdasarkan pilihan
    switch selectedEdge
        case 'Prewitt'
            processedImg = edge(grayImg, 'prewitt');
        case 'Sobel'
            processedImg = edge(grayImg, 'sobel');
        case 'Canny'
            processedImg = edge(grayImg, 'canny');
        otherwise
            msgbox('Please select a valid edge detection method');
            return;
    end

    % Tampilkan gambar di axes2 (gambar hasil after)
    axes(handles.axes2);
    imshow(processedImg);
    handles.processedImg = processedImg;  % Update processedImg untuk ditampilkan

    % Tampilkan histogram hasil di axes4
    axes(handles.axes4);
    imhist(processedImg);
    
    % Perbarui handles
    guidata(hObject, handles);
else
    msgbox('Please select an image first');
end

% --- Executes on button press in rotate.
    function rotate_Callback(hObject, eventdata, handles)
    % hObject    handle to rotate (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % Sudut rotasi ke kanan (90 derajat)
    angle = 90;

    % Memeriksa apakah gambar sudah dimuat
    if isfield(handles, 'processedImg')
        % Melakukan rotasi gambar 90 derajat ke kanan tanpa pemotongan
        rotatedImg = imrotate(handles.processedImg, -angle, 'bilinear', 'loose'); % rotasi ke kanan tanpa pemotongan

        % Menyimpan hasil rotasi untuk rotasi berikutnya
        handles.processedImg = rotatedImg;

        % Menampilkan gambar hasil rotasi pada axes2
        axes(handles.axes2);
        imshow(rotatedImg);

        % Menampilkan histogram dari gambar hasil rotasi pada axes4
        axes(handles.axes4);
        cla; % Membersihkan histogram sebelumnya
        if size(rotatedImg, 3) == 3
            % Jika gambar berwarna, tampilkan histogram RGB
            R = rotatedImg(:,:,1);
            G = rotatedImg(:,:,2);
            B = rotatedImg(:,:,3);
            hold on;
            histogram(R(:), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.3);
            histogram(G(:), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.3);
            histogram(B(:), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.3);
            hold off;
        else
            % Jika gambar grayscale, tampilkan histogram grayscale
            imhist(rotatedImg);
        end
        title('Histogram After Rotation');

        % Memperbarui struktur handles
        guidata(hObject, handles);
    else
        msgbox('Please select an image first');
    end

% --- Executes on button press in horizontal.
function horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'processedImg')  % Pastikan gambar sudah dimuat
    flippedImg = flip(handles.processedImg, 2);  % Membalik gambar secara horizontal
    handles.processedImg = flippedImg;  % Menyimpan hasil ke handles
    
    % Menampilkan gambar hasil flip horizontal pada axes2
    axes(handles.axes2);
    imshow(flippedImg);
    
    % Menampilkan histogram dari gambar hasil horizontal pada axes4
    axes(handles.axes4);
    cla; % Membersihkan histogram sebelumnya
    if size(flippedImg, 3) == 3
            % Jika gambar berwarna, tampilkan histogram RGB
            R = flippedImg(:,:,1);
            G = flippedImg(:,:,2);
            B = flippedImg(:,:,3);
            hold on;
            histogram(R(:), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.3);
            histogram(G(:), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.3);
            histogram(B(:), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.3);
            hold off;
    else
        imhist(flippedImg);
    end
    title('Histogram After Flip Horizontal');
    
    guidata(hObject, handles);  % Memperbarui handles
else
    msgbox('Please select an image first');
end

% --- Executes on button press in vertical.
function vertical_Callback(hObject, eventdata, handles)
% hObject    handle to vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'processedImg')  % Pastikan gambar sudah dimuat
    flippedImg = flip(handles.processedImg, 1);  % Membalik gambar secara vertikal
    handles.processedImg = flippedImg;  % Menyimpan hasil ke handles
    
    % Menampilkan gambar hasil flip vertikal pada axes2
    axes(handles.axes2);
    imshow(flippedImg);
    
    % Menampilkan histogram dari gambar hasil vertikal pada axes4
    axes(handles.axes4);
    cla; % Membersihkan histogram sebelumnya
    if size(flippedImg, 3) == 3
            % Jika gambar berwarna, tampilkan histogram RGB
            R = flippedImg(:,:,1);
            G = flippedImg(:,:,2);
            B = flippedImg(:,:,3);
            hold on;
            histogram(R(:), 'FaceColor', 'r', 'EdgeColor', 'r', 'FaceAlpha', 0.3);
            histogram(G(:), 'FaceColor', 'g', 'EdgeColor', 'g', 'FaceAlpha', 0.3);
            histogram(B(:), 'FaceColor', 'b', 'EdgeColor', 'b', 'FaceAlpha', 0.3);
            hold off;
    else
        imhist(flippedImg);
    end
    title('Histogram After Flip Vertical');
    
    guidata(hObject, handles);  % Memperbarui handles
else
    msgbox('Please select an image first');
end

% --- Executes during object creation, after setting all properties.
function contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject, 'Min', 0);
set(hObject, 'Max', 50);
set(hObject,'Value',0);

% --- Executes on button press in horizontal.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in vertical.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
contrastValue = get(hObject, 'Value');
set(handles.edit5, 'String', num2str(contrastValue));

   if isfield(handles, 'processedImg')
        Img = handles.processedImg;
    elseif isfield(handles, 'Img')
        Img = handles.Img;
    else
        disp('Tidak ada gambar untuk diproses.');
        return;
   end
    
    if islogical(Img)
        Img = uint8(Img) * 255; % Konversi dari biner ke grayscale
    end

    contrastAdjustment = 1 + (contrastValue / 50);
    processedImg = imadjust(Img, [], [], contrastAdjustment);
    handles.processedImage = processedImg;
    
     % Konversi kembali ke biner jika gambar awal adalah biner
    if islogical(handles.Img)
        processedImg = imbinarize(processedImg, 0.5); % Threshold 0.5 atau sesuai kebutuhan
    end
    
    axes(handles.axes2);
    imshow(processedImg);
    
    axes(handles.axes4);
    
    if size(processedImg, 3) == 3
        redChannel = processedImg(:,:,1);
        greenChannel = processedImg(:,:,2);
        blueChannel = processedImg(:,:,3);
        
        axes(handles.axes4);
        [countsRed, binLocations] = imhist(redChannel, 256);
        countsGreen = imhist(greenChannel, 256);
        countsBlue = imhist(blueChannel, 256);
        
        plot(binLocations, countsRed, 'r', 'LineWidth', 1.5); hold on;
        plot(binLocations, countsGreen, 'g', 'LineWidth', 1.5);
        plot(binLocations, countsBlue, 'b', 'LineWidth', 1.5); hold off;
        xlim([0 255]);
    else
        imhist(processedImg);
    end
    
    handles.AdjustImage = processedImg;
    guidata(hObject, handles);


% --- Executes on slider movement.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Mengambil pilihan edge detection dari popup menu
contents = cellstr(get(hObject, 'String'));
handles.edgeMethod = contents{get(hObject, 'Value')};
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
blurValue = str2double(get(hObject, 'String'));  % Mengonversi string menjadi angka
    
% Validasi nilai input
if isnan(blurValue) || blurValue < 0 || blurValue > 255
    % Jika nilai tidak valid, tampilkan peringatan
    msgbox('Masukkan nilai blur antara 0 dan 255.');
    return;
end

% Update nilai blur pada slider jika ada
set(handles.blur, 'Value', blurValue);

% Panggil fungsi blur untuk memproses gambar
blur_Callback(handles.blur, eventdata, handles);


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

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
% Mendapatkan nilai yang dimasukkan oleh pengguna di edit2
sharpValue = str2double(get(hObject, 'String'));

% Validasi nilai input
if isnan(sharpValue) || sharpValue < 0 || sharpValue > 100
    msgbox('Masukkan nilai ketajaman antara 0 dan 100.');
    return;
end

% Tampilkan nilai yang dimasukkan ke dalam edit2
set(handles.sharpness, 'Value', sharpValue);

% Panggil fungsi blur untuk memproses gambar
sharpness_Callback(handles.sharpness, eventdata, handles);

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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
brightValue = str2double(get(hObject, 'String'));

% Validasi nilai input
if isnan(brightValue) || brightValue < -50 || brightValue > 50
    msgbox('Masukkan nilai brightness antara -50 dan 50.');
    return;
end

% Tampilkan nilai yang dimasukkan ke dalam edit2
set(handles.brightness, 'Value', brightValue);

% Panggil fungsi blur untuk memproses gambar
brightness_Callback(handles.brightness, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
noiseValue = str2double(get(hObject, 'String'));

% Validasi nilai input
if isnan(noiseValue) || noiseValue < 0 || noiseValue > 50
    msgbox('Masukkan nilai noise antara 0 dan 50.');
    return;
end

% Tampilkan nilai yang dimasukkan ke dalam edit2
set(handles.noise, 'Value', noiseValue);

% Panggil fungsi blur untuk memproses gambar
noise_Callback(handles.noise, eventdata, handles);

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

% Hints: get(h Object,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
contrastValue = str2double(get(hObject, 'String'));

% Validasi nilai input
if isnan(contrastValue) || contrastValue < 0 || contrastValue > 50
    msgbox('Masukkan nilai contrast antara 0 dan 50.');
    return;
end

% Tampilkan nilai yang dimasukkan ke dalam edit2
set(handles.contrast, 'Value', contrastValue);

% Panggil fungsi blur untuk memproses gambar
contrast_Callback(handles.contrast, eventdata, handles);

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
