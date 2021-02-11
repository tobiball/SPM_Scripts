%-----------------------------------------------------------------------
% spm SPM - SPM12 (7219)
%-----------------------------------------------------------------------
% Based on script by Andrew Jahn
% Build to analyse subject fmri data from assignment in methods for neuroeconomists at uva

subjects = [427]; % Replace with a list of all of the subjects you wish to analyze

user = 'tobi'

for subject=subjects
    
%subject = num2str(subject, '%02d'); % Zero-pads each number so that the subject ID is 2 characters long

%%%%%%%%%%

% Check whether the files have been unzipped. If not, unzip them using
% gunzip

% if exist(['/Users/' user '/Desktop/Flanker/sub-' subject '/func/sub-' subject '_task-flanker_run-1_bold.nii']) == 0
%     display('Run 1 has not been unzipped; unzipping now')
%     gunzip(['/Users/' user '/Desktop/Flanker/sub-' subject '/func/sub-' subject '_task-flanker_run-1_bold.nii.gz'])
% else
%     display('Run 1 is already unzipped; doing nothing')
% end
% 
% if exist(['/Users/' user '/Desktop/Flanker/sub-' subject '/func/sub-' subject '_task-flanker_run-2_bold.nii']) == 0
%     display('Run 2 has not been unzipped; unzipping now')
%     gunzip(['/Users/' user '/Desktop/Flanker/sub-' subject '/func/sub-' subject '_task-flanker_run-2_bold.nii.gz'])
% else
%     display('Run 2 is already unzipped; doing nothing')
% end
% 
% if exist(['/Users/' user '/Desktop/Flanker/sub-' subject '/anat/sub-' subject '_T1w.nii']) == 0
%     display('Anatomical image has not been unzipped; unzipping now')
%     gunzip(['/Users/' user '/Desktop/Flanker/sub-' subject '/anat/sub-' subject '_T1w.nii.gz'])
% else
%     display('Anatomical image is already unzipped; doing nothing')
% end

%%%%%%%%%%

% Execute the code specified in the SPM GUI

run1 = '/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii';
run2 = '/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii';
run3 = '/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii';

[dim1 x] =  size(spm_vol('/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'))
[dim2 x] =  size(spm_vol('/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'))
[dim3 x] =  size(spm_vol('/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'))

fnms1={};
for i = 1:dim1
    fnms1{i} = [run1 ',' num2str(i) ];
end

fnms2={};
for i = 1:dim2
    fnms2{i} = [run2 ',' num2str(i) ];
end

fnms3={};
for i = 1:dim3
    fnms3{i} = [run3 ',' num2str(i) ];
end



matlabbatch{1}.spm.spatial.realign.estwrite.data={fnms1',fnms2',fnms3'};
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

% matlabbatch{2}.spm.temporal.st.nslices = 36;
% matlabbatch{2}.spm.temporal.st.tr = 2;
% matlabbatch{2}.spm.temporal.st.ta = 1.94444444444444;
% matlabbatch{2}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36];
% matlabbatch{2}.spm.temporal.st.refslice = 18;
% matlabbatch{2}.spm.temporal.st.prefix = 'a';


spm_jobman('run', matlabbatch);

end
