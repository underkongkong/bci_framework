cfg                = [];
cfg.channel        = 1:8;                         % list with channel "names"
cfg.blocksize      = 0.04;                            % seconds
cfg.fsample        = 250;                          % sampling frequency
cfg.target.dataset = 'buffer://localhost:1972';    % where to write the data
ft_realtime_signalproxy(cfg)