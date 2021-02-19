% List of open inputs
nrun = 3; % enter the number of runs here
jobfile = {'/home/tobi/projects/uni/meths_for_neuro/data/sub-427/normalisation_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
