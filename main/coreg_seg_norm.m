%-----------------------------------------------------------------------
% spm SPM - SPM12
%-----------------------------------------------------------------------
% Based on script by Andrew Jahn
% Build to analyse subject fmri data from assignment in methods for neuroeconomists at uva

clear

% specify subjects and path
subjects = [438,439,440,441]; % Replace with a list of all of the subjects you wish to analyze
path = '/home/tobi/projects/uni/meths_for_neuro/data/'; %specify path where subject data is saved
% %Iterate over subjects
for subject=subjects
% REALIGNMENT
    % Execute the code specified in the SPM GUI


    matlabbatch{1}.spm.spatial.coreg.estimate.ref = {['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/func/meansub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii,1']};
    matlabbatch{1}.spm.spatial.coreg.estimate.source = {[path 'sub-' num2str(subject) '/anat/sub-' num2str(subject) '_T1w.nii,1']};
    matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
    %execute job
    spm_jobman('run', matlabbatch);
    
    
    smatlabbatch{1}.spm.spatial.preproc.channel.vols = {[path 'sub-' num2str(subject) '/anat/sub-' num2str(subject) '_T1w.nii,1']};
    smatlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
    smatlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
    smatlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
    smatlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,1'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
    smatlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];x
    smatlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,2'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
    smatlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,3'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
    smatlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,4'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
    smatlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,5'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
    smatlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'/home/tobi/projects/uni/meths_for_neuro/spm/spm12/tpm/TPM.nii,6'};
    smatlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
    smatlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
    smatlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
    smatlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
    smatlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    smatlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
    smatlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
    smatlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
    smatlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];
    smatlabbatch{1}.spm.spatial.preproc.warp.vox = NaN;
    smatlabbatch{1}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                                  NaN NaN NaN];
    spm_jobman('run', smatlabbatch);

    
    arrun1 = [path 'sub-' num2str(subject) '/func/arsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    arrun2 = [path 'sub-' num2str(subject) '/func/arsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    arrun3 = [path 'sub-' num2str(subject) '/func/arsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'];
    
    % Find number of temp files (dim*) for subject by run
    [ardim1 x] =  size(spm_vol(arrun1));
    [ardim2 x] =  size(spm_vol(arrun2));
    [ardim3 x] =  size(spm_vol(arrun3));
    
    % Specify temp file names
    arfnms1={};
    arfnms2={};
    arfnms3={};
    for i = 1:ardim1
        arfnms1{i} = [arrun1 ',' num2str(i)];
    end
    for i = 1:ardim2
        arfnms2{i} = [arrun2 ',' num2str(i)];
    end
    for i = 1:ardim3
        arfnms3{i} = [arrun3 ',' num2str(i)];
    end
    arfnms = arfnms1;
    for i = 1:3
        armatlabbatch{1}.spm.spatial.normalise.write.subj.def = {['/home/tobi/projects/uni/meths_for_neuro/data/sub-' num2str(subject) '/anat/y_sub-' num2str(subject) '_T1w.nii']};
        armatlabbatch{1}.spm.spatial.normalise.write.subj.resample = arfnms';
        armatlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70; 78 76 85];
        armatlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
        armatlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
        armatlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
        %execute job
        spm_jobman('run', armatlabbatch);
        
        if i == 1
            arfnms = arfnms2;
        else
            arfnms = arfnms3;
        end
    end
    
    warrun1 = [path 'sub-' num2str(subject) '/func/warsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    warrun2 = [path 'sub-' num2str(subject) '/func/warsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    warrun3 = [path 'sub-' num2str(subject) '/func/warsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'];
    
    % Find number of temp files (dim*) for subject by run
    [wardim1 x] =  size(spm_vol(warrun1));
    [wardim2 x] =  size(spm_vol(warrun2));
    [wardim3 x] =  size(spm_vol(warrun3));
    
    % Specify temp file names
    warfnms1={};
    warfnms2={};
    warfnms3={};
    for i = 1:wardim1
        warfnms1{i} = [warrun1 ',' num2str(i) ];
    end
    for i = 1:wardim2
        warfnms2{i} = [warrun2 ',' num2str(i) ];
    end
    for i = 1:wardim3
        warfnms3{i} = [warrun3 ',' num2str(i) ];
    end
    warfnms = warfnms1;
    for i = 1:3
        warmatlabbatch{1}.spm.spatial.smooth.data = warfnms';
        warmatlabbatch{1}.spm.spatial.smooth.fwhm = [6 6 6];
        warmatlabbatch{1}.spm.spatial.smooth.dtype = 0;
        warmatlabbatch{1}.spm.spatial.smooth.im = 0;
        warmatlabbatch{1}.spm.spatial.smooth.prefix = 's';
        spm_jobman('run', warmatlabbatch);
        if i == 1
            warfnms = warfnms2;
        else
            warfnms = warfnms3;
        end
    end
end
