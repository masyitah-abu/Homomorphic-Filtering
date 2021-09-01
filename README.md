# Homomorphic-Filtering

- What is Homomorphic Filtering?
  - Homorphic Filtering involving a nonlinear mapping to a different domain in which linear filter techniques are applied, followed by mapping back to the original domain.
  - In this project a raw image that added with noise will be used to see the performance of the filter.
  - There raw data used for image filtering is this image:
<p align="center">
  <img width="20%" height="20%" src="https://github.com/masyitah-abu/Homomorphic-Filtering/blob/main/raw.png">
</p>

- This algorithm consist several process
  1. Add speckle noise into the original image
<p align="center">
  <img width="20%" height="20%" src="https://github.com/masyitah-abu/Homomorphic-Filtering/blob/main/raw.png">
</p>

  3. Filter noise added using homomorphic filtering
      - There are three types of homomorphic filtering is developed following this three Equation:- 
        <p align="left">
          Equation 1 = (E {|S(jw)|^2}) / (E {|S(jw)|^2} + E {|N(jw)|^2})  
        </p>   
        <p align="left">
          Equation 2 = (E {|S(jw)|^2}) / (E {|R(jw) - S(jw) - log k|^2})
        </p>
        <p align="left">
          Equation 3 = |< R(jw) >^2| / <|R(jw)|^2>
        </p>               
  
  3. Then, the performance of homomorphic filtering will be measured using PSNR, SNR and MSE
  4. The filter used for homomorphic filter are wiener filter
  5. The output is present in table below:
      - Type 1 
  
        | FIlter Name | PSNR  | SNR  | MSE  |
        | :-------:   | :---: | :--: | :---:|
        | Wiener      | 52.072|45.761|0.4035|
    
      - Type 2 
  
        | FIlter Name | PSNR  | SNR  | MSE  |
        | :-------:   | :---: | :--: | :---:|
        | Wiener      |7.7511 |1.44  |10914 |
        
      - Type 3 
  
        | FIlter Name | PSNR  | SNR  | MSE   |
        | :-------:   | :---: | :--: | :----:|
        | Wiener      |54.637 |48.326|0.22354|
        
        
- Specification used for this work:
  - Matlab 2018a 

