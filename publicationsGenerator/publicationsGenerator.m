
clc

% LOAD ------------------------------------------
importTable = readtable('table.xlsx');
i=0;
for index = 1:size(importTable,1)

    condition = string(cell2mat(importTable{index,2})) ~= "" && ...
                string(cell2mat(importTable{index,3})) ~= "" && ...
                string(cell2mat(importTable{index,5})) ~= "" && ...
                string(cell2mat(importTable{index,6})) ~= "";
    
    if condition
    i = i + 1;
    disp(['Load ' num2str(i) ' of ' num2str(size(importTable,1))])
    
%   publication(i).Number = string(importTable(i,:).N);
    publication(i).Title = string(cell2mat(importTable(index,:).title));
    publication(i).Authors = string(cell2mat(importTable(index,:).authors));
    publication(i).Date = string(importTable(index,:).date);
    publication(i).Year = extractBetween(publication(i).Date,7,10);
    publication(i).Journal = string(cell2mat(importTable(index,:).journal));
    publication(i).Source = string(cell2mat(importTable(index,:).source));

    else 
        disp(newline)
        warning('Missing data !!!');
        disp(['Missing data in ' num2str(index) ' row of table']);
        disp(newline)
        beep
        continue
    end

        
    % replace "�" by "-"
    publication(i).Title = strrep(publication(i).Title,"�","-");
    publication(i).Authors = strrep(publication(i).Authors,"�","-");
	% replace "?" by "C"
    publication(i).Title = strrep(publication(i).Title,"?","C");
    publication(i).Authors = strrep(publication(i).Authors,"?","C");
    % replace ? by s
    publication(i).Title = strrep(publication(i).Title,"?","s");
    publication(i).Authors = strrep(publication(i).Authors,"?","s");
    % replace "�" by "-"
    publication(i).Title = strrep(publication(i).Title,"�","-");
    publication(i).Authors = strrep(publication(i).Authors,"�","-");
    % replace "?" by "i"
    publication(i).Title = strrep(publication(i).Title,"?","i");
    publication(i).Authors = strrep(publication(i).Authors,"?","i");    
    % replace "?" by "u"
    publication(i).Title = strrep(publication(i).Title,"?","u");
    publication(i).Authors = strrep(publication(i).Authors,"?","u");    
    % replace "?" by "n"
    publication(i).Title = strrep(publication(i).Title,"?","n");
    publication(i).Authors = strrep(publication(i).Authors,"?","n");  
    % replace "?" by "i"
    publication(i).Title = strrep(publication(i).Title,"?","i");
    publication(i).Authors = strrep(publication(i).Authors,"?","i"); 
    % replace "�"(UTF??) by "" (emtpy)
    publication(i).Source = strrep(publication(i).Source,"�","");
    
    
    [M1 I1] = max(double(char(publication(i).Title)));
    [M2 I2] = max(double(char(publication(i).Authors)));
    [M3 I3] = max(double(char(publication(i).Journal)));
    [M4 I4] = max(double(char(publication(i).Source)));
    if (M1>122 | M2>122 | M3>122 | M4>122) | (M1<65 | M2<65 | M3<65 | M4<65)
        [i]
        [1 M1 I1]
        [2 M2 I2]
        [3 M3 I3]
        [4 M4 I4]
        publication(i).Title
        publication(i).Authors
        publication(i).Journal
        publication(i).Source
        warning('Wrong chars!!!')
        break
    end
    
end
NumberOfElements = i;
disp(newline)
%------------------------------------------------


%%

% SAVE ------------------------------------------
folder = 'output';
for i = 1:NumberOfElements
    disp(['Save ' num2str(i) ' of ' num2str(size(importTable,1))])
    
fileNum = num2str(i,'%04u');
filename = [fileNum '.md'];
fileaddr = [folder '/' filename];
fileid = fopen(fileaddr, 'wt' );

fprintf(fileid, "---\n");
fprintf(fileid, "layout: publication\n");
fprintf(fileid, "title: """ + publication(i).Title + """\n");
fprintf(fileid, "authors: """ + publication(i).Authors + """\n");
fprintf(fileid, "date: " + publication(i).Date + "\n");
fprintf(fileid, "year: " + publication(i).Year + "\n");
fprintf(fileid, "journal: """ + publication(i).Journal + """\n");
fprintf(fileid, "source: " + publication(i).Source + "\n");
fprintf(fileid, "---\n");

fclose(fileid);
end
%------------------------------------------------

fclose('all');

% example ---------------------------------------

% ---
% layout: publication
% title: "Electrical Conductivity of NaNO2 Confined within Porous Glass"
% authors: "L. Korotkova, V. Dvornikova, M. Vlasenko, T. Korotkova, A. Naberezhnov, Ewa Rysiakiewicz-Pasek"
% date: 2012-12-20
% year: 2012
% journal: Ferroelectrics
% source: http://www.tandfonline.com/doi/abs/10.1080/00150193.2013.786600
% ---










