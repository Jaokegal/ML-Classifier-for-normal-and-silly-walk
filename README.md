# Monty Matlab SS24
This project is the final project for Monty MATLAB in SS24. The task of the project is to distinguish or categorize between a normal walk and a silly walk. What we are trying to do is to train an intelligent algorithm, i.e. a machine learning model, to do the classification task for us.
## Team Member:
- Mengtian Xu
- Shuchen Xu
- Peilin Lu
- Junqing Du

## Data Collection
The data was collected by using a MATLAB APP on a mobile phone to record acceleration data during normal and silly walking.

## Experimental Procedures
The implementation process involves preparing the data, feeding the data into the model for training, and using the trained model for the classification test task. We compared the LSTM layer with the GRU layer and according to the test results, the GRU model performed better, so we used the GRU model. We defaulted maxEpochs to 50 and miniBatchSize to 16.

## GUI
The GUI has buttons for loading training and test sets so that the model can be trained using your own data, plus the user is free to change the sampling rate and window length, as well as the Epoch and Batch size.The training results can be displayed by the accuracy and the pointer indicating the disc.

Another thing to note is that when users select the data they want to train, they need to save the new data in the TrainingData and TestData folders, and these two folders need to be placed in the subdirectory of the GUI folder, and the rest of the functions in the GUI should not be altered.

## Classification Results
After UNI TEST, we get the following accuracy rates:

Accuracy: 96.6292%

Balanced accuracy: 94.8946%

