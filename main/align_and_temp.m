%-----------------------------------------------------------------------
% spm SPM - SPM12 (7219)
%-----------------------------------------------------------------------
% Based on script by Andrew Jahn
% Build to analyse subject fmri data from assignment in methods for neuroeconomists at uva

clear

subjects = [427,437,438,439,440,441]; % Replace with a list of all of the subjects you wish to analyze
%

user = 'tobi';

for subject=subjects
    
    % Execute the code specified in the SPM GUI
    run1 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    run2 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    run3 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];

    [dim1 x] =  size(spm_vol(run1));
    [dim2 x] =  size(spm_vol(run2));
    [dim3 x] =  size(spm_vol(run3));

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
    
    spm_jobman('run', matlabbatch);
    
    rrun1 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii']
    rrun2 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii']
    rrun3 = ['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/rsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii']
    
    rfnms1={};
    for i = 1:dim1
        rfnms1{i} = [rrun1 ',' num2str(i) ];
    end

    rfnms2={};
    for i = 1:dim2
        rfnms2{i} = [rrun2 ',' num2str(i) ];
    end

    rfnms3={};
    for i = 1:dim3
        rfnms3{i} = [rrun3 ',' num2str(i) ];
    end

   
    rmatlabbatch{1}.spm.temporal.st.scans = {rfnms1',fnms2',fnms3'};
    rmatlabbatch{1}.spm.temporal.st.nslices = 36;
    rmatlabbatch{1}.spm.temporal.st.tr = 2;
    rmatlabbatch{1}.spm.temporal.st.ta = 1.94444444444444;
    rmatlabbatch{1}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36];
    rmatlabbatch{1}.spm.temporal.st.refslice = 18;
    rmatlabbatch{1}.spm.temporal.st.prefix = 'a';

    spm_jobman('run', rmatlabbatch);

end
