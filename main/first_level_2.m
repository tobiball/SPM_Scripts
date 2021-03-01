%-----------------------------------------------------------------------
% Job saved on 24-Feb-2021 12:46:54 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown

clear

% specify subjects and path
subjects = [437:441]; % Replace with a list of all of the subjects you wish to analyze
path = '/home/tobi/projects/uni/methods_for_neuro/'; %specify path where subject data is saved

% %Iterate over subjects
for subject=subjects
% REALIGNMENT
    % Execute the code specified in the SPM GUI
    run1 = [path 'data/sub-' num2str(subject) '/func/swarsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'];
    run2 = [path 'data/sub-' num2str(subject) '/func/swarsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.nii'];
    run3 = [path 'data/sub-' num2str(subject) '/func/swarsub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.nii'];
    
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
%-----------------------------------------------------------------------
    matlabbatch{1}.spm.stats.fmri_spec.dir = {[path 'fmri_G11/fmri_analysis/GLM2/1stLevel/sub-' num2str(subject) ]};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 36;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 18;
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = fnms1';
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {[path 'fmri_G11/fmri_analysis/GLM2/regressors/sub-' num2str(subject) '/GLM2_nodur_s1.mat']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {[path 'data/sub-' num2str(subject) '/func/rp_sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.txt']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = fnms2';
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = {[path 'fmri_G11/fmri_analysis/GLM2/regressors/sub-' num2str(subject) '/GLM2_nodur_s2.mat']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = {[path 'data/sub-' num2str(subject) '/func/rp_sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-2_bold.txt']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 128;
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).scans = fnms3';
    %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).multi = {[path 'fmri_G11/fmri_analysis/GLM2/regressors/sub-' num2str(subject) '/GLM2_nodur_s3.mat']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).multi_reg = {[path 'data/sub-' num2str(subject) '/func/rp_sub-' num2str(subject) '_task-RLconf_acq-SeqMm3Tr2000_run-3_bold.txt']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).hpf = 128;

    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    %% execute job
    spm_jobman('run', matlabbatch);
    
    ematlabbatch{1}.spm.stats.fmri_est.spmmat = {[path 'fmri_G11/fmri_analysis/GLM2/1stLevel/sub-' num2str(subject) '/SPM.mat']};
    ematlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
    ematlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
    spm_jobman('run', ematlabbatch);
end