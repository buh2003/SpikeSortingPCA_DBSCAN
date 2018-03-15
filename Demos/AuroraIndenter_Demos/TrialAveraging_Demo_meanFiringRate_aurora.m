%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.24.16
%
% Modeled using 4PL
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -------- Set figure title names and dock all figures
dataName_agg = '2-14-18 Unit 1 MS'; %add general name
dataName1 = '2-14-18 Unit 1 MS Trial 2 analyzed'; % add Trial 1 file name!
dataName2 = '2-14-18 Unit 1 MS Trial 3 analyzed'; % add Trial 2 file name! (If necessary)
dataName3 = '091417 ADRB2 flox 112 fiber2 trial3 analyzed'; % add Trial 3 file name! (If necessary)
dataName4 = '041916 B2ARflox 37 Rleg leg2 trial4 analyzed'; % add Trial 4 file name! (If necessary)
set(0,'DefaultFigureWindowStyle','docked')
%% -------- Step 1: Prepare Data from each trial for averaging
%  -------- Step 1: Number of Trials
Trials = 2; % ENTER NUMBER OF TRIALS
%%  -------- Step 1-1: Load Trial 1, Round Disp
[Dy_Trial1, mfr_trial1] = import_data_mfr(dataName1);
Dynamic= Dy_Trial1; Mfr = mfr_trial1;
%%  -------- Step 1-2: Load Trial 2, Round Disp
[Dy_Trial2, mfr_trial2] = import_data_mfr(dataName2);
Dynamic = [Dynamic; Dy_Trial2]; Mfr = [Mfr; mfr_trial2];
%%  -------- Step 1-3: Load Trial 3, Round Disp
[Dy_Trial3, mfr_trial3] = import_data_mfr(dataName3);
Dynamic = [Dynamic; Dy_Trial3]; Mfr = [Mfr; mfr_trial3];
%%  -------- Step 1-4: Load Trial 4, Round Disp
[Dy_Trial4, mfr_trial4] = import_data_mfr(dataName4);
Dynamic = [Dynamic; Dy_Trial4]; Mfr = [Mfr; mfr_trial4];
%% -------- Step 2: Combine trials, perform stats
%  -------- Step 2-1: Generate IFF values
[Dynamic, Mfr] = generate_IFF(Dynamic, Mfr);
%  -------- Step 2-2: Generate aggregate means and standard deviations from rounded displacement grouping
[Dynamic_agg, Mfr_agg] = aggregate_trials(Dynamic, Mfr);
%% -------- Step 3: Perform Sigmoid fit
[Dynamic_IFF_fit, Dynamic_gof, Mfr_IFF_fit, Mfr_gof] = sig_fit_mfr(Dynamic_agg, Mfr_agg, dataName1); % dataName1 must have the word 'trial'
[Dynamic_IFF_fit_force, Dynamic_gof_force, Mfr_IFF_fit_force, Mfr_gof_force] = sig_fit_force_mfr(Dynamic_agg, Mfr_agg, dataName1);
%% -------- Step 4: Save data to .xlsx
% Choose Mac or PC script
% For Mac
save_boltz_data(Dynamic_IFF_fit, Dynamic_gof, Dynamic_agg, Mfr_IFF_fit, Mfr_gof, Mfr_agg, dataName_agg)
% For PC
%save_boltz_data_windows(Dynamic_IFF_fit, Dynamic_gof, Dynamic_agg, Mfr_IFF_fit, Mfr_gof, Mfr_agg, dataName_agg)
