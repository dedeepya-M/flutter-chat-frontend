# MediBuddy!

Welcome to **MediBuddy**! Here we provide basic answers for your medical queries
Your First Line Of Care.

 - A **large language** model which acts as a **recommendation system** which runs locally on your PC
 - Can identify vast number of diseases based on given symptoms and be a **robust first responder** to give precautions as required
 - Restricated and **ultra specialized for pediatric use**
 - Based on **Meta AI’s state of the art open source AI-basesd LLM model**
 - **Custom fine-tuned model** based on medical textbooks including Gale Encyclopedia of Medicine,Essential Pediatric Medicine as well as Medical Pharmology

# Technology Stack

 - LLM(LLAMA 2.0 7B)
 - Vector DataBase(FAISS)
 - LangChain
 - ChainLit

# Training steps

 - **Data Collection**- Acquired various Textbooks of medicine curated by doctors to train our LLM.
 - **Data Preprocess**-PDF's of Textbooks were fed to LangChain Document Ingestor. It takes the PDF and applies advanced OCR tools to take the text data and add it to the document in a recursive manner using 500 tokens for each document and overlapping 50 tokens.
 - **VectorDB Creation** - A vector database is a type of database that stores data as high-dimensional vectors, which are mathematical representations of features or attributes. It mainly stored the embeddings of the data we created. We use FAISS(**Facebook AI Similarity Search**) created by Facebook to store and search the similarity between the query embedding and the embedding in the vector database.
 - **Model Inference**-Inference is done using LLaMA model which was introduced by the Meta AI Research team and is a collection of many transformers and has 7B parameters.
 - **Fine Tuning** -The model was fine-tuned on new Medical data and restrictions were imposed by setting a pre prompt that sets the conditions and what the output should be the limit of what the model outputs

# Files

The weight file for the llama-2-7b is available [here](https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/blob/main/llama-2-7b-chat.ggmlv3.q8_0.bin). Add this file to the root directory after cloning the repository.

# Screen shots
![Screenshot](https://user-images.githubusercontent.com/77972976/275280954-1df2a07a-c976-469c-9e22-1ba54604f4c9.png)

![Screenshot](https://user-images.githubusercontent.com/77972976/275281046-c3490306-8640-409f-bfa8-fe9667a829a7.png)
