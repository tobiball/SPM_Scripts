%-----------------------------------------------------------------------
% spm SPM - SPM12
%-----------------------------------------------------------------------
% Based on script by Andrew Jahn
% Build to analyse subject fmri data from assignment in methods for neuroeconomists at uva

clear

% specify subjects and path
subjects = [427]; % Replace with a list of all of the subjects you wish to analyze
path = '/home/tobi/projects/uni/methods_for_neuro/data/'; %specify path where subject data is saved

% %Iterate over subjects
for subject=subjects
% REALIGNMENT
    % Execute the code specified in the SPM GUI
    run1 = [path 'sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    run2 = [path 'sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    run3 = [path 'sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'];
    
    % Find number of temp files (dim*) for subject by run
    [dim1 x] =  size(spm_vol(run1));
    [dim2 x] =  size(spm_vol(run2));
    [dim3 x] =  size(spm_vol(run3));
    
    % Specify temp file names
    fnms1={};
    fnms2={};
    fnms3={};
    for i = 1:dim1
        fnms1{i} = [run1 ',' num2str(i) ];
    end
    for i = 1:dim2
        fnms2{i} = [run2 ',' num2str(i) ];
    end
    for i = 1:dim3
        fnms3{i} = [run3 ',' num2str(i) ];
    end

    matlabbatch{1}.spm.spatial.realign.estwrite.data={fnms1',fnms2',fnms3'}; %data to analyse
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
    %execute job
    spm_jobman('run', matlabbatch);
    
    
% TIMING CORRECTION
    rrun1 = [path 'sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    rrun2 = [path 'sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    rrun3 = [path 'sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'];
    
    % Find number of temp files (dim*) for subject by run
    [rdim1 x] =  size(spm_vol(rrun1));
    [rdim2 x] =  size(spm_vol(rrun2));
    [rdim3 x] =  size(spm_vol(rrun3));
    
    % Specify temp file names
    rfnms1={};
    rfnms2={};
    rfnms3={};
    for i = 1:rdim1
        rfnms1{i} = [rrun1 ',' num2str(i) ];
    end
    for i = 1:rdim2
        rfnms2{i} = [rrun2 ',' num2str(i) ];
    end
    for i = 1:rdim3
        rfnms3{i} = [rrun3 ',' num2str(i) ];
    end

    rmatlabbatch{1}.spm.temporal.st.scans = {rfnms1',rfnms2',rfnms3'}; %data to analyse
    rmatlabbatch{1}.spm.temporal.st.nslices = 36;
    rmatlabbatch{1}.spm.temporal.st.tr = 2;
    rmatlabbatch{1}.spm.temporal.st.ta = 1.94444444444444;
    rmatlabbatch{1}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36];
    rmatlabbatch{1}.spm.temporal.st.refslice = 18;
    rmatlabbatch{1}.spm.temporal.st.prefix = 'a';
    %execute job
    spm_jobman('run', rmatlabbatch);

end
