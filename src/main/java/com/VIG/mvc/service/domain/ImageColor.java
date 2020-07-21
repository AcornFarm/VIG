package com.VIG.mvc.service.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class ImageColor implements Serializable{	
	
	private int colorId;
	private int ImageId;
	
	private float red;
	private float green;
	private float blue;
	
	//이미지에서 해당 색이 차지하는 비율
	private float ratio;
	
	public ImageColor() {}

}
