function variance_explained = emgvariance(t0, t1)
% Calculate variance explained by current decomposition
% Returns the fraction of signal variance explained by the decomposition
% Added by Pranav Mamidanna.

global DECOMP

% Default return value
variance_explained = 0;

% Check if we have any units
if DECOMP.nunits == 0
    return;
end

% Get the original signal and residual
try
    original = emgsignal(t0, t1);
    residual = emgresidual(t0, t1);
    
    % Calculate variances
    original_var = var(original.sig);
    residual_var = var(residual.sig);
    
    % Calculate variance explained
    if original_var > 0
        variance_explained = 1 - (residual_var / original_var);
        % Ensure it's between 0 and 1
        variance_explained = max(0, min(1, variance_explained));
    end
catch
    % If any error occurs, return 0
    variance_explained = 0;
end
