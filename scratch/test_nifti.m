run1 = '/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii';

[dim x] =  size(spm_vol('/home/tobi/projects/uni/meths_for_neuro/data/sub-427/func/sub-427_task-RLconf_acq-SeqMm3Tr2000_run-1_bold.nii'))

fnms={};
for i = 1:dim
    fnms{i} = [run1 ',' num2str(i) ];
end